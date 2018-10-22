package com.cultivodatos.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.NamedStoredProcedureQueries;
import javax.persistence.NamedStoredProcedureQuery;
import javax.persistence.StoredProcedureParameter;
import javax.persistence.ParameterMode;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "precios_cultivos")
@IdClass(value=PrecioCultivo.class)
@Data
@NamedStoredProcedureQueries({
        @NamedStoredProcedureQuery(name = "_lstPreciosCultivo",
            procedureName = "_spGetPreciosCultivo", 
    		parameters = { 
    		        @StoredProcedureParameter(
    		          name = "cveCultivo", 
    		          type = Integer.class, 
    		          mode = ParameterMode.IN) 
	        },
            resultClasses = Precios.class
            )
})

public class Precios implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	private Integer cve_cultivo;
    
    @Id
	private Integer cve_destino;
    
    
	private Float precio;
	private Float min_precio;
	private Float max_precio;
	private Date fecha_act;
	
	public Integer getCve_cultivo() {
		return cve_cultivo;
	}
	public void setCve_cultivo(Integer cve_cultivo) {
		this.cve_cultivo = cve_cultivo;
	}
	public Integer getCve_destino() {
		return cve_destino;
	}
	public void setCve_destino(Integer cve_destino) {
		this.cve_destino = cve_destino;
	}
	public Float getPrecio() {
		return precio;
	}
	public void setPrecio(Float precio) {
		this.precio = precio;
	}
	public Float getMin_precio() {
		return min_precio;
	}
	public void setMin_precio(Float min_precio) {
		this.min_precio = min_precio;
	}
	public Float getMax_precio() {
		return max_precio;
	}
	public void setMax_precio(Float max_precio) {
		this.max_precio = max_precio;
	}
	public Date getFecha_act() {
		return fecha_act;
	}
	public void setFecha_act(Date fecha_act) {
		this.fecha_act = fecha_act;
	}
	
	
}
