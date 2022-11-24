import tareas.*
import proyectos.*

//Template Method
class Persona {
	var property nombre = ""
	const tiempoTareaIdeal = 30
	const cantidadPersonasIdealQueRealizanLaTarea = 3
	var property tareasAgignadas = []
	
	method leGusta(tarea) = tarea.tiempoEstimadoDeRealizacion() < tiempoTareaIdeal and self.leGustaHacer(tarea) 
	
	method leGustaHacer(tarea) = tarea.personasQueLaRealizan().size() > cantidadPersonasIdealQueRealizanLaTarea
	
	// Punto 5 en tarea.asignarPersona(self) se valida si le gusta
	method asignar(tarea) = if (tarea.asignarPersona(self)) self.tareasAgignadas().add(tarea) else throw new DomainException(message = " No Se puede Asignar Tarea a Persona") 
	
	
	
}


object pam inherits Persona(nombre = "pam") {
	
	override method leGustaHacer(tarea) = tarea.personasQueLaRealizan().contains(jim)
}


object jim inherits Persona(nombre = "jim") {
	
	override method leGustaHacer(tarea) = !tarea.oficina()
	
}

object dwight inherits Persona(nombre = "dwight") {
	
	const puntosRecompensaDeseado = 100
	override method leGustaHacer(tarea) = tarea.puntosDeRecompensa() > puntosRecompensaDeseado
	
}