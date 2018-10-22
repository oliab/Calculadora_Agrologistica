package com.cultivodatos.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "ejes")
public class Ejes {

	@Id
	private Integer clave;
	
	private String eje;
	
	public Integer getClave() {
		return clave;
	}
	public void setClave(Integer clave) {
		this.clave = clave;
	}
	public String getEje() {
		return eje;
	}
	public void setEje(String eje) {
		this.eje = eje;
	}
}
