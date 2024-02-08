# db/seed.rb

# Limpiar datos existentes
Access.destroy_all
Link.destroy_all
User.destroy_all

# Crear usuarios
user1 = User.create(email: 'user1@example.com', password: 'password')
user2 = User.create(email: 'user2@example.com', password: 'password')
user3 = User.create(email: 'user3@example.com', password: 'password')

# Crear enlaces
link1 = user1.links.create(name: 'Link Regular 1', url: 'http://regular1.com', type: 'Link')
link2 = user1.links.create(name: 'Link Temporal 1', url: 'http://temporal1.com', type: 'Temporal', expiration_date: Time.now + 7.days)
link3 = user1.links.create(name: 'Link Efímero 1', url: 'http://efimero1.com', type: 'Efimero')
link4 = user1.links.create(name: 'Link Privado 1', url: 'http://privado1.com', type: 'Privado', password: 'cata123')

link5 = user2.links.create(name: 'Link Regular 2', url: 'http://regular2.com', type: 'Link')
link6 = user2.links.create(name: 'Link Temporal 2', url: 'http://temporal2.com', type: 'Temporal', expiration_date: Time.now + 7.days)
link7 = user2.links.create(name: 'Link Efímero 2', url: 'http://efimero2.com', type: 'Efimero')
link8 = user2.links.create(name: 'Link Privado 2', url: 'http://privado2.com', type: 'Privado', password: 'cata123')

link9 = user3.links.create(name: 'Link Regular 3', url: 'http://regular3.com', type: 'Link')
link10 = user3.links.create(name: 'Link Temporal 3', url: 'http://temporal3.com', type: 'Temporal', expiration_date: Time.now + 7.days)
link11 = user3.links.create(name: 'Link Efímero 3', url: 'http://efimero3.com', type: 'Efimero')
link12 = user3.links.create(name: 'Link Privado 3', url: 'http://privado3.com', type: 'Privado', password: 'cata123')

link13 = user1.links.create(name: 'Otro Link Regular 1', url: 'http://otro_regular1.com', type: 'Link')
link14 = user2.links.create(name: 'Otro Link Regular 2', url: 'http://otro_regular2.com', type: 'Link')
link15 = user3.links.create(name: 'Otro Link Regular 3', url: 'http://otro_regular3.com', type: 'Link')

# Crear accesos
def create_accesses(link, count)
  count.times do |i|
    link.accesses.create(ip_address: "192.168.0.#{i + 1}", created_at: Time.now - i.days)
  end
end

create_accesses(link1, 10)
create_accesses(link2, 10)
create_accesses(link3, 10)
create_accesses(link4, 10)
create_accesses(link5, 10)
create_accesses(link6, 10)
create_accesses(link7, 10)
create_accesses(link8, 10)
create_accesses(link9, 10)
create_accesses(link10, 10)
create_accesses(link11, 10)
create_accesses(link12, 10)
create_accesses(link13, 10)
create_accesses(link14, 10)
create_accesses(link15, 10)