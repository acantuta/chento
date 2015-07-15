# Generated with RailsBricks

#Elimina registros anteriores
Doclog.destroy_all
Docmovimiento.destroy_all
Docreferencia.destroy_all
Documento.destroy_all
Userasignacion.destroy_all
User.destroy_all
Area.destroy_all
Doctipo.destroy_all
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

tipos_documento = ['Solicitud', 'Oficio', 'Carta']
nombres = ['JUAN', 'MARIA', 'JOSÉ', 'GUSTAVO', 'LUIS', 'YOVANA','KATY', 'GABRIEL', 'FRANKLIN', 'VICTOR', 'DIEGO', 'FRANZ', 'RODRIGO']
apellidos = ['PEREZ', 'CRUZ', 'MAMANI', 'QUISPE', 'ARPASI', 'REAÑO','JUAREZ', 'PAREDES', 'PARI', 'QUISPE', 'YUFRA', 'GUTIERREZ', 'HUAMAN', 'CHAMBILLA']

areas.each do |area|
  Area.create(nombre: area)
end

tipos_documento.each do |tipos_documento|
  Doctipo.create(nombre: tipos_documento)
end

(1..areas.count).each do |n|
  u = User.new
  u.username = n.to_s.rjust(8,'0')
  u.fullname = "#{nombres.sample} #{nombres.sample} #{apellidos.sample} #{apellidos.sample}"
  u.email = "#{u.username}@example.com"
  u.password = '1234'
  u.password_confirmation = '1234'
  u.skip_confirmation!
  u.save!

  a = Area.offset(n-1).first
  ua = Userasignacion.new
  ua.user = u
  ua.area = a
  ua.es_jefe = true
  ua.save
end

# Creando documentos
count_doctipo = Doctipo.count
count_user = User.count
count_area = Area.count
count_movaccion = Movaccion.count
500.times do 

  offset_doctipo = rand(count_doctipo)
  offset_user_remitente = rand(1...count_user)
  offset_user_destinatario = rand(1...count_user)
  offset_area = rand(count_area)
  offset_area_destino = rand(count_area)
  offset_movaccion = rand(count_movaccion)

  random_user_remitente = User.offset(offset_user_remitente).first
  random_user_destinatario = User.offset(offset_user_destinatario).first
  random_area = Area.offset(offset_area).first
  random_area_destino = Area.offset(offset_area_destino).first

  begin
    offset_area_destino = rand(count_area)
    random_area_destino = Area.offset(offset_area_destino).first
  end while(random_area_destino.id == random_area.id)
  
  random_movaccion = Movaccion.offset(offset_movaccion).first

  d = Documento.new
  d.doctipo = Doctipo.offset(offset_doctipo).first
  d.nro = "NRO #{rand(1..9999999999).to_s.rjust(10,'0')}"
  d.asunto = "Asunto #{Faker::Lorem.sentence}"
  d.user = random_user_remitente
  d.remitente = random_user_remitente.fullname
  d.cod_remitente = random_user_remitente.username
  d.destinatario = random_user_destinatario.fullname
  d.area_generadora_id = random_area.id
  d.save!


  Doclog.create(documento_id: d.id, contenido: "Se ha registrado documento.")

  dm = Docmovimiento.new
  dm.area_fuente = random_area
  dm.area_destino = random_area_destino
  dm.movaccion = random_movaccion
  dm.documento = d
  dm.recibido = true
  dm.save

  area_envia = random_area

  documento_hijo = d
  cant_doc = rand(1..15)
  cant_doc.times do |i|
    begin
      offset_area_destino = rand(count_area)
      random_area_destino = Area.offset(offset_area_destino).first
    end while(random_area_destino.id == area_envia.id)

    d = Documento.new
    d.doctipo = Doctipo.offset(offset_doctipo).first
    d.nro = "NRO #{rand(1..9999999999).to_s.rjust(10,'0')}"
    d.asunto = "Asunto #{Faker::Lorem.sentence}"
    d.user = random_user_remitente
    d.remitente = random_user_remitente.fullname
    d.cod_remitente = random_user_remitente.username
    d.destinatario = random_user_destinatario.fullname
    d.area_generadora_id = area_envia.id
    d.documento_hijo = documento_hijo

    dm = Docmovimiento.new
    dm.area_fuente = area_envia
    dm.area_destino = random_area_destino
    dm.movaccion = random_movaccion
    dm.documento = d

    if(i == (cant_doc-1) )
      dm.recibido = [true, false].sample
      #dm.recibido = true
    else
      dm.recibido = true
    end
    
    area_envia = dm.area_destino 
    documento_hijo = d

    dm.save!
    
    
  end
end
