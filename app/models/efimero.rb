class Efimero < Link
    has_many :accesses, as: :link
end
