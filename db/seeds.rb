# Generated with RailsBricks

#Elimina registros anteriores
Doclog.destroy_all
Docmovimiento.destroy_all
Docreferencia.destroy_all
Documento.destroy_all
Userasignacion.destroy_all
User.destroy_all
Area.destroy_all
# Initial seed file to use with Devise User Model

# Temporary admin account
u = User.new(
    username: "admin",
    email: "admin@example.com",
    password: "1234",
    password_confirmation: "1234",
    admin: true
)
u.skip_confirmation!
u.save!

#Registrando
areas = [
'Rectorado',
'Control interno', 
'Secretaría General', 
'Comunicación e imagen institucional', 
'Infraestructura',
'Asesoría Legal', 
'Planificación, Cooperación y Vinculación Universidad-Empresa-Estado',
'Vicerrectorado e investigación',
'Institutos de investigación',
'Editorial Universitaria',
'Vicerrectorado Académico',
'Extensión Cultural, Proyección y Responsabilidad Social Universitaria',
'Servicios Académicos',
'Bienestar Universitario',
'Admisión y Centro Pre-Universitario',
'Calidad Universitaria y Acreditación',
'Dirección General de Administración',
'Recursos Humanos',
'Economía y Finanzas',
'Logística, Mantenimiento y Servicios Generales',
'Tecnología, Información y Comunicación',
'Facultad de Ingeniería',
'Unidad Investigación - Facultad de Ingeniería',
'Unidad Postgrado - Facultad de Ingeniería',
'Agroindustrial',
'Agronómica',
'Sistemas e informática',
'Mecánica Eléctrica',
'Civil',
'Ambiental',
'Arquitectura',
'Facultad de Cs. Jurídicas, Empresariales y Pedagógicas',
'Unidad de Postgrado - Facultad de Cs. Jurídicas, Empresariales y Pedagógicas',
'Derecho',
'Contabilidad',
'Administración Turística y Hotelera',
'Cs. Administrativas y Marketing Estratégico',
'Educación',
'Economía',
'Ingeniería Comercial',
'Facultad de Ciencias de la Salud',
'Unidad de Investigación - Facultad de Ciencias de la Salud',
'Unidad Postgrado - Facultad de Ciencias de la Salud',
'Obstetricia',
'Enfermería',
'Odontología',
'Psicología',
'Clínica Odontología',
'Escuela de Postgrado'
]
nombres = ['JUAN', 'MARIA', 'JOSÉ', 'GUSTAVO', 'LUIS', 'YOVANA','KATY', 'GABRIEL', 'FRANKLIN', 'VICTOR', 'DIEGO', 'FRANZ', 'RODRIGO']
apellidos = ['PEREZ', 'CRUZ', 'MAMANI', 'QUISPE', 'ARPASI', 'REAÑO','JUAREZ', 'PAREDES', 'PARI', 'NINARAQUE', 'YUFRA', 'GUTIERREZ']

areas.each do |area|
  Area.create(nombre: area)
end


(1..areas.count).each do |n|
  u = User.new
  u.username = n.to_s.rjust(8,'0')
  u.fullname "#{nombres.sample} #{nombres.sample} #{apellidos.sample} #{apellidos.sample}"
  u.email = "#{u.username}@example.com"
  u.password = '1234'
  u.password_confirmation = '1234'
  u.skip_confirmation!
  u.save!
end