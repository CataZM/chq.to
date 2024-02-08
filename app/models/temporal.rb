class Temporal < Link
    has_many :accesses, as: :link
end
