class Privado < Link
    has_many :accesses, as: :link
end
