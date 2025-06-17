class Viaje {
  var idiomas
  method implicaEsfuerzo()
  method sirveParaBroncearse ()
  method duracion()
  method esInteresante() = idiomas.size()>1
  method esRecomendada(socio) = self.esInteresante() && socio.leAtrae(self) && !socio.actividadesRealizadas().contains(self)
}
class ViajeDePlaya inherits Viaje{
  var largo
  override method duracion() = largo/500
  override method implicaEsfuerzo() = largo > 1200
  override method sirveParaBroncearse() = true
}
class ExcursionACiudad inherits Viaje {
  var atracciones
  override method duracion() = atracciones / 2
  override method implicaEsfuerzo() = atracciones.between(5, 8)
  override method sirveParaBroncearse() = false 
  override method esInteresante() = super() or atracciones==5
}
class ExcursionACiudadTropical inherits ExcursionACiudad {
  override method duracion() = super() + 1
  override method sirveParaBroncearse() = true
}
class SalidaDeTrekking inherits Viaje {
 var kilometros
 var diasDeSol
override method duracion() = kilometros / 50
  override method implicaEsfuerzo() = kilometros > 80
  override method sirveParaBroncearse() = diasDeSol>200 or (diasDeSol>100 && diasDeSol<200 && kilometros>120) 
override method esInteresante() = super() && diasDeSol>140
}
class ClaseDeGimnasia {
  method idiomas() =["español"]
  method duracion() = 1
  method implicaEsfuerzo() = true
  method sirveParaBroncearse() = false
  method esRecomendada(socio) = socio.edad().between(20, 30)

}
class Socio {
  var edad
  var idiomas
  var actividadesRealizadas
  var maximoPermitido
  method edad() = edad
  method adoradorDelSol() = actividadesRealizadas.all({a=>a.sirveParaBroncearse()})
  method actividadesEsforzadas() = actividadesRealizadas.filter({a=>a.implicaEsfuerzo()})
  method actividadesRealizadas() = actividadesRealizadas
  method realizar(unaActividad) {
    if(self.llegoAlMaximo()){
      self.error("Ya no puede realizar actividades")
    } else{
      actividadesRealizadas.add(unaActividad)
    }    
  }
  method llegoAlMaximo() = actividadesRealizadas.size() == maximoPermitido
  method leAtrae(unaActividad)
}
class SocioTranquilo inherits Socio{
  override method leAtrae(unaActividad) = unaActividad.duracion() >= 4
}
class SocioCoherente inherits Socio {
  override method leAtrae(unaActividad) = if (self.adoradorDelSol()) unaActividad.sirveParaBroncearse() else unaActividad.implicaEsfuerzo()

}
class SocioRelajado inherits Socio {
  override method leAtrae(unaActividad) = idiomas.intersection(unaActividad.idiomas())
}
class TallerLiterario inherits Viaje {
  var libros
  method idiomas() = libros.idiomas()
  override method duracion() = libros.size() + 1
  override method implicaEsfuerzo() = libros.any({l=>l.paginas() > 500 or libros.all({a,b=>b.autor() == a.autor()})})
  override method sirveParaBroncearse() = false
  override method esRecomendada(socio) = socio.idiomas().size() > 1
}
