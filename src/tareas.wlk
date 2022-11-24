import personas.*
import proyectos.*

class Tarea {
	var property personasQueLaRealizan = []
	var property descripcion = ""
	var property tiempoEstimadoDeRealizacion = 0 // Solo para la inicializacion luego se setea en la instanciacion
	var property tiempoEfectivoDeRealizacion = 0 // Solo para la inicializacion luego se setea en la instanciacion
	var property oficina = true
	var property fechaLimiteDeRealizacion = new Date () // Solo para la inicializacion luego se setea en la instanciacion 
	var property fechaEfectivaRealizacion = new Date () // Solo para la inicializacion luego se setea en la instanciacion 
	var property fechaInicio = new Date () // Si interpreta el dia de comiendo de tarea cuando se instancia
	var property recompensas = [] // Patron Strategy, lista de recompensas
	var property realizada = false
	
	const recompensaMinima = 1
	
	
	method seRealizaAlExterior() = !oficina 

	method seRealizaEnLaOficina() = oficina	
	
	method seCumpleATiempo()  =  self.diferenciaDias() == 0
	
	method diferenciaDias() = 0.max(self.fechaLimiteDeRealizacion() - self.fechaEfectivaRealizacion()) // TODO Revisar calculos
 
	method diferenciaMinutos() = 0.max(self.tiempoEstimadoDeRealizacion() - self.tiempoEfectivoDeRealizacion()) // TODO Revisar calculos
	
	method puntosDeRecompensa() = (recompensas.map({ recompensa => recompensa.puntosRecompensa(self)})).sum()
	
	method asignarPersona(persona) {
		
		self.validarPersona(persona)
		self.agregarPersonaATarea(persona)	
		
	}
	
	method validarPersona(persona) {
		
		if (!persona.leGustaHacer(self)) throw new DomainException(message = self.mensajeValidacionNoOK(persona))
		
		if ((self).puntosDeRecompensa() > recompensaMinima) throw new DomainException(message = self.mensajeValidacionNoOK(persona) + " por no tener puntos de recompensa minimos " + recompensaMinima.toString())
		
		if (!(self).realizada()) throw new DomainException(message = self.mensajeValidacionNoOK(persona) + " por no tener puntos de recompensa minimos " + recompensaMinima.toString())
		
			
	}
	
	method agregarPersonaATarea(persona) { personasQueLaRealizan.add(persona) }
	
	method mensajeValidacionNoOK(persona) = "A la persona " + persona.toString() + " no le gusta la tarea " + self.descripcion() + " "
	
}

object exterior {

	const recompensaDeseada = 50
	
	method puntosRecompensa(tarea) = if (tarea.seRealizaAlExterior()) recompensaDeseada else 0 // TODO ver si es correcto el 0 
	
}

object diasTrabajados {
	
		const recompensaDiasTrabajados = 30 
		
		method puntosRecompensa(tarea) = if (tarea.realizada()) (self.calcularRecompensa(tarea)) else 0
		
		method calcularRecompensa(tarea) = if (!tarea.seCumpleATiempo() and tarea.realizada()) tarea.diferenciaMinutos() * recompensaDiasTrabajados else 0
		
}

object personas {
	
	const personasCohesion = 3
	const recompensaPersonasCohesion = 20
	const recompensaPersonasStandard = 10
	
	method puntosRecompensa(tarea) = if (self.equipoCohesivo(tarea)) recompensaPersonasCohesion else recompensaPersonasStandard
	
	method equipoCohesivo(tarea) = tarea.personasQueLaRealizan().size() >= personasCohesion

}


object minutos {
	
		const recompensaMinutos = 5 
		
		method puntosRecompensa(tarea) = if (tarea.realizada()) (self.calcularRecompensaMinutos(tarea)) else 0
		
		method calcularRecompensaMinutos(tarea) = 100.min(if (!tarea.seCumpleATiempo() and tarea.realizada()) tarea.diferenciaDias() * recompensaMinutos else 0)
		
}




