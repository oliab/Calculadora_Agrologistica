package com.cultivodatos.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "destinos")
public class Destino {

	@Id
	private Integer clave;
	
	private String destino;
	private Double lat;
	private Double lng;
	private Integer id_f;
	private Integer source_f;
	private Integer target_f;
	
	@Transient
	private Double venta;
	@Transient
	private Double pUnitario;
	@Transient
	private Date fPrecio;
	
	public Integer getClave() {
		return clave;
	}
	public void setClave(Integer clave) {
		this.clave = clave;
	}
	public String getDestino() {
		return destino;
	}
	public void setDestino(String destino) {
		this.destino = destino;
	}
	public Double getLat() {
		return lat;
	}
	public void setLat(Double lat) {
		this.lat = lat;
	}
	public Double getLng() {
		return lng;
	}
	public void setLng(Double lng) {
		this.lng = lng;
	}
	public Integer getId_f() {
		return id_f;
	}
	public void setId_f(Integer id_f) {
		this.id_f = id_f;
	}
	public Integer getSource_f() {
		return source_f;
	}
	public void setSource_f(Integer source_f) {
		this.source_f = source_f;
	}
	public Integer getTarget_f() {
		return target_f;
	}
	public void setTarget_f(Integer target_f) {
		this.target_f = target_f;
	}
	public Double getpUnitario() {
		return pUnitario;
	}
	public void setpUnitario(Double pUnitario) {
		this.pUnitario = pUnitario;
	}
	public Date getfPrecio() {
		return fPrecio;
	}
	public void setfPrecio(Date fPrecio) {
		this.fPrecio = fPrecio;
	}
	public Double getVenta() {
		return venta;
	}
	public void setVenta(Double venta) {
		this.venta = venta;
	}
}
