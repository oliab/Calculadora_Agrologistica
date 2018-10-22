package com.cultivodatos.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedStoredProcedureQueries;
import javax.persistence.NamedStoredProcedureQuery;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "tipo_vehiculo")
@Data
@NamedStoredProcedureQueries({
        @NamedStoredProcedureQuery(name = "_lstCatVehiculos",
            procedureName = "_spGetCatVehiculos", 
            resultClasses = CategoriaVehiculo.class
            )
})
public class CategoriaVehiculo {
	
	@Id
	private Integer id_tipo;
	
	private String categoria;

	public String getCategoria() {
		return categoria;
	}

	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}

	public Integer getId_tipo() {
		return id_tipo;
	}

	public void setId_tipo(Integer id_tipo) {
		this.id_tipo = id_tipo;
	}
	
}
