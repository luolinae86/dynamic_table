# DynamicTable                                                                                                
Use DynamicTable class method **create_table** to create table dynamically with dynamic class name，and use class method **get_dynamic_class** to get class name to perform model operations

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dynamic_table'
```

And then execute:

    $ bundle

Or install it yourself as: 

    $ gem install dynamic_table

## Usage

Any class include DynamicTable module  will extend DynamicTable's class method:
- create_table 
- get_dynamic_class
- rename_table
- drop_table

Suppose:
- class name is SendLog
- Date.today is "Tue, 11 Jul 2017"

### create_table
```
SendLog.create_table
```
Will create class SendLog170711 with table_name send_logs_170711

```
SendLog.create_table(Date.today-1.days)
```
Will create class SendLog170710 with table_name send_logs_170710

### get_dynamic_class
Use get_dynamic_class to get class name,and then perform model operations
```
SendLog.get_dynamic_class
```
If SendLog170711 exist ,it will return SendLog170711
else return Center170711(Table doesn't exist)

```
SendLog.get_dynamic_class(Date.today-1.days).where("id=?",1)
```
Will generate the following SQL

```
SELECT `send_logs_170711`.* FROM `send_logs_170711` WHERE (id=1)
```

### rename_table
SendLog.rename_table old_table_name,new_table_name

### drop_table
SendLog.drop_table

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/luolinae86/dynamic_table.
