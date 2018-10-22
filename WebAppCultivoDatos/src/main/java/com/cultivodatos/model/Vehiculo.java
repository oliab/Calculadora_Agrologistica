package com.cultivodatos.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedStoredProcedureQueries;
import javax.persistence.NamedStoredProcedureQuery;
import javax.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "vehiculos")
@Data
@NamedStoredProcedureQueries({
        @NamedStoredProcedureQuery(name = "_lstVehiculos",
            procedureName = "_spGetVehiculos", 
            resultClasses = Vehiculo.class
            )
})


public class Vehiculo  implements Serializable {
	

	private static final long serialVersionUID = 1L;

	@Id
	private Integer clave;	
	
	private String vehiculo;
	private int activo;
	private int id_tveh;
	public Integer getClave() {
		return clave;
	}
	public void setClave(Integer clave) {
		this.clave = clave;
	}
	public String getVehiculo() {
		return vehiculo;
	}
	public void setVehiculo(String vehiculo) {
		this.vehiculo = vehiculo;
	}
	public int getActivo() {
		return activo;
	}
	public void setActivo(int activo) {
		this.activo = activo;
	}
	public int getId_tveh() {
		return id_tveh;
	}
	public void setId_tveh(int id_tveh) {
		this.id_tveh = id_tveh;
	}
	

}
