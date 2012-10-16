module SolrSearch
  module Initiatives
    def self.included(base)
      base.class_eval do
        searchable :auto_index => true, :auto_remove => true do
          time    :presented_at,        stored: true
          text    :description,         stored: true
          text    :title,               stored: true
          string  :state,               stored: true
          string  :representative_name, stored: true do
            representative_name.try(:removeaccents).try(:downcase)
          end
          integer :commission_ids,      multiple: true
          string  :topic_ids,           multiple: true
        end
        
        def self.filters(filters)
          (search do
            paginate :page => filters[:page], :per_page => filters[:per_page] || 25
            
            fulltext filters[:title] if filters[:title].present?
            fulltext filters[:description] if filters[:description].present?
            fulltext filters[:keywords] if filters[:keywords].present?
            
            any_of do
              with(:representative_name, filters['representative_name'].removeaccents.downcase) if filters['representative_name'].present?
              with(:representative_name).starting_with(filters['representative_name'].removeaccents.downcase) if filters['representative_name'].present?
            end

            with(:state, filters[:state]) if filters[:state].present?
            with(:commission_ids).any_of(filters['commission_ids'].split(',')) if filters['commission_ids'].present?
            
          end)
        end
      end
    end
  end
end