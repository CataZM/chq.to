class Efimero < LinkRegular
    has_many :accesses, as: :link
end
