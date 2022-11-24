import tareas.*
import proyectos.*
import personas.*

class Equipos {
	
	var property coordinador = new Persona()
	var property integrantes = []
	
	// Punto 5 en tarea.asignarPersona(self) se valida si le gusta y dispara Excepcion
	method asignar(tarea) {
		self.asignarACoordinador(tarea)
		self.asignarAIntegrantes(tarea)
	}
	
	method asignarACoordinador(tarea) { tarea.asignarPersona(coordinador) }
	method asignarAIntegrantes(tarea) { integrantes.forEach({persona => tarea.asignarPersona(persona)}) }
	
	
}
