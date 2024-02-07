class Privado < LinkRegular
    has_many :accesses, as: :link
end
