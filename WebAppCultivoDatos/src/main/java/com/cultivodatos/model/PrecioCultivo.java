package com.cultivodatos.model;

import java.io.Serializable;
import java.util.Objects;

public class PrecioCultivo  implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private Integer cve_cultivo;
	private Integer cve_destino;
	
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
}
