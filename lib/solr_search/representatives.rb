module SolrSearch
  module Representatives
    def self.included(base)
      base.class_eval do
        searchable :auto_index => true, :auto_remove => true do
          string  :name,                 stored: true do
            name.try(:removeaccents).try(:downcase)
          end
          string  :first_name,           stored: true do
            first_name.try(:removeaccents).try(:downcase)
          end
          string  :last_name,            stored: true do
            last_name.try(:removeaccents).try(:downcase)
          end
          
          text  :name,                 stored: true do
            name.try(:removeaccents).try(:downcase)
          end
          text  :first_name,           stored: true do
            first_name.try(:removeaccents).try(:downcase)
          end
          text  :last_name,            stored: true do
            last_name.try(:removeaccents).try(:downcase)
          end
          
          
          string  :political_party_name, stored: true
          string  :region_id,            stored: true do
            region_id || 0
          end
          integer :commission_ids,       stored: true, multiple: true
          string  :email,                stored: true
          string  :twitter,              stored: true
        end

        def self.filters(filters)
          (search do
            paginate :page => filters[:page], :per_page => filters[:per_page] || 25
            
            fulltext(filters['search']) if filters['search']
            
            fulltext(filters['name'], fields: [:name, :first_name, :last_name]) if filters['name'].present?
            
            with(:political_party_name, filters['political_party_name']) if filters['political_party_name'].present?
            with(:region_id, filters['region_name']) if filters['region_name'].present?
            with(:email, filters['email']) if filters['email'].present?
            with(:twitter, filters['twitter']) if filters['twitter'].present?

            with(:commission_ids).any_of(filters['commission_ids'].split(',')) if filters['commission_ids'].present?
          end)
        end
      end
    end
  end
end