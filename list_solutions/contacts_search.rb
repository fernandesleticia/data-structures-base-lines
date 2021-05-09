queries = ['add let', 'add leonard', 'find le', 'find ha']
contacts = ['john']

def agenda(contacts, queries)
    output = []
    queries.each do |query|
        contact = query.split.last

        contacts = add_contact(contacts, contact) if query.start_with?('add')
        output << find_contact(contacts, contact).count if query.start_with?('find')        
    end

    output
end

def add_contact(contacts, new_contact)
    contacts << new_contact
end

def find_contact(contacts, contact)
    contacts.grep(/^#{contact}/)
end

agenda(contacts, queries)