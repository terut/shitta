ActiveSupport.on_load :active_record do
  module ActiveRecord::ConnectionAdapters
    class AbstractMysqlAdapter
      def create_table_with_innodb_row_format(table_name, options = {}, &block)
        table_options = options.reverse_merge(:options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC')
        create_table_without_innodb_row_format(table_name, table_options, &block)
      end
      alias_method_chain :create_table, :innodb_row_format
    end
  end
end
