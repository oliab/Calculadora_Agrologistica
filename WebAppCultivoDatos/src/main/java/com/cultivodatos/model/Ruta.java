package com.cultivodatos.model;

import java.util.Date;

public class Ruta {

	private Float long_km;
	private Float costo_caseta;
	private Float eje_excedente;
	private Float tiempo_min;
	private String peaje;
	private String geojson;
	private String destino;
	private Float lat;
	private Float lng;
	private Double venta;
	private Double pUnitario;
	private Double pCombustible;
	private Date fPrecio;
		
	public Float getLong_km() {
		return long_km;
	}
	public void setLong_km(Float long_km) {
		this.long_km = long_km;
	}
	public Float getCosto_caseta() {
		return costo_caseta;
	}
	public void setCosto_caseta(Float costo_caseta) {
		this.costo_caseta = costo_caseta;
	}
	public Float getEje_excedente() {
		return eje_excedente;
	}
	public void setEje_excedente(Float eje_excedente) {
		this.eje_excedente = eje_excedente;
	}
	public Float getTiempo_min() {
		return tiempo_min;
	}
	public void setTiempo_min(Float tiempo_min) {
		this.tiempo_min = tiempo_min;
	}
	public String getPeaje() {
		return peaje;
	}
	public void setPeaje(String peaje) {
		this.peaje = peaje;
	}
	public String getGeojson() {
		return geojson;
	}
	public void setGeojson(String geojson) {
		this.geojson = geojson;
	}
	public String getDestino() {
		return destino;
	}
	public void setDestino(String destino) {
		this.destino = destino;
	}
	public Float getLat() {
		return lat;
	}
	public void setLat(Float lat) {
		this.lat = lat;
	}
	public Float getLng() {
		return lng;
	}
	public void setLng(Float lng) {
		this.lng = lng;
	}
	public Double getVenta() {
		return venta;
	}
	public void setVenta(Double venta) {
		this.venta = venta;
	}
	public Double getpUnitario() {
		return pUnitario;
	}
	public void setpUnitario(Double pUnitario) {
		this.pUnitario = pUnitario;
	}
	public Double getpCombustible() {
		return pCombustible;
	}
	public void setpCombustible(Double pCombustible) {
		this.pCombustible = pCombustible;
	}
	public Date getfPrecio() {
		return fPrecio;
	}
	public void setfPrecio(Date fPrecio) {
		this.fPrecio = fPrecio;
	}
}
