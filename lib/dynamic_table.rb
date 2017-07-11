require "dynamic_table/version"

module DynamicTable
  extend ActiveSupport::Concern

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods

    def create_table date=Date.today
      new_table_name = set_table_name date
      conn = ActiveRecord::Base.connection
      conn.execute "create table `#{new_table_name}` like  #{self.table_name}" unless conn.table_exists? new_table_name
    end

    def get_dynamic_class(date = Date.today)
      class_name = set_class_name(date)
      class_name.constantize
    rescue NameError
      define_dynamic_class(date)
    end

    def rename_table old_table_name,new_table_name
      conn = ActiveRecord::Base.connection
      conn.execute "rename table #{old_table_name} to #{new_table_name}" if conn.table_exists? old_table_name
    end

    def drop_table table_name
      conn = ActiveRecord::Base.connection
      conn.execute "drop table #{table_name}" if conn.table_exists? table_name
    end

    #select records with time range 
    def union_table begin_date=1.month.ago.to_date, end_date = Date.today
      dates = (begin_date..end_date).to_a.uniq{|x| x.strftime('%y%m%d') }
      result = self.all
      dates.each do |date|
        result = result.union(get_dynamic_class(date).all) if ActiveRecord::Base.connection.table_exists? set_table_name(date)
      end
      result
    end

    private

    def set_table_name date = Date.today
      "#{table_name}_#{date_suffix date}"
    end

    def set_class_name(date = Date.today)
      "#{name}_#{date_suffix date}".classify
    end

    def date_suffix(date = Date.today)
      date.strftime '%y%m%d'
    end

    def define_dynamic_class(date = Date.today)
      class_name = set_class_name date
      table_name = set_table_name date
      Object.const_set class_name, Class.new(ActiveRecord::Base) { self.table_name = "#{table_name}" }
      class_name.constantize
    end
  end

end
