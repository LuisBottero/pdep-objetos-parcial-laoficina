import personas.*
import tareas.*
import equipos.*

class Proyecto {
	
	var property tareas = []
	var property equipos = []

	const puntajeDeBusqueda = 100
		
	
	method tareasRealizadas() = tareas.filter { tarea => tarea.realizada() }
	
	method tareasRealizadasConPuntajeMayorA() = self.tareasRealizadas().filter({tarea => (tarea.puntosDeRecompensa() >=  puntajeDeBusqueda)})
	
	// TODO refactorizar con any
	method personasQueHicieronAlgunaTareaCon() = (self.tareasRealizadasConPuntajeMayorA()).forEach({personas1, personas2 => personas1 + personas2})
	
	method nombreDeLasPersonasQueHicieronAlgunaTareaCon() = self.personasQueHicieronAlgunaTareaCon().map({ persona => persona.nombre()}) // TODO Revisar tipos
	

}

