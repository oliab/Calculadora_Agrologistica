package com.cultivodatos.controllers;


import java.io.InputStreamReader;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.cultivodatos.model.Calculadora;
import com.cultivodatos.model.CategoriaVehiculo;
import com.cultivodatos.model.CategoriaVehiculoDAO;
import com.cultivodatos.model.Cultivo;
import com.cultivodatos.model.CultivoDAO;
import com.cultivodatos.model.Destino;
import com.cultivodatos.model.DestinoDAO;
import com.cultivodatos.model.Ejes;
import com.cultivodatos.model.EjesDAO;
import com.cultivodatos.model.Precios;
import com.cultivodatos.model.PreciosDAO;
import com.cultivodatos.model.Ruta;
import com.cultivodatos.model.Vehiculo;
import com.cultivodatos.model.VehiculoDAO;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
public class RutaCtrl {
	
	@Autowired
    private DestinoDAO destinoDao;
	
	@Autowired
    private CultivoDAO cultivoDao;
	
	@Autowired
    private CategoriaVehiculoDAO catVehDao;
	
	@Autowired
    private VehiculoDAO vehiculoDao;
	
	@Autowired
    private EjesDAO ejesDao;
	
	@Autowired
    private PreciosDAO preciosDao;
	
	@Value("${apisakbe.config.token}")
	private String aSakbeToken;

	@Value("${apisakbe.config.url_base_ruta}")
	private String aSakbeUrlBaseRuta;
	
	@Value("${apisakbe.config.url_base_ruta_pin}")
	private String aSakbeUrlBaseRutaPin;
	
	@Value("${apisakbe.config.num_max}")
	private int aSakbeNumMax;
	
	
	
	@RequestMapping(value={"ruta"}, method = RequestMethod.POST) 
	public TreeMap<Double, List<Ruta>> getRuta(@RequestBody Calculadora calculadora) {
		
		TreeMap<Double, Destino> sDestinos = new TreeMap<Double, Destino>();
	  	TreeMap<Double, List<Ruta>> sRutas = new TreeMap<Double, List<Ruta>>();
	  	
	  	
	  	System.out.println(aSakbeToken);
	  	System.out.println(aSakbeUrlBaseRuta);
	  		  		  
	  	List<Destino> destinos = destinoDao.findAll();
	  	for(Destino destino: destinos) {
	  		sDestinos.put(distance( destino.getLat().doubleValue(),
	  								destino.getLng().doubleValue(),
	  								calculadora.getLat(), 
	  								calculadora.getLng(),'K'), 
	  					  destino);
	  	}
	  	
	  	
	  	List<Precios> lstPrecios = preciosDao.getPreciosCultivo(new Integer(calculadora.getCultivo()));
	  	
	  	TreeMap<Double, Destino> pDestinos = new TreeMap<Double, Destino>();	  	
	  	for(Precios precio: lstPrecios) {
	  		for(Map.Entry<Double,Destino> sDes : sDestinos.entrySet()) {
	  		   Destino des = sDes.getValue();	  		  
	  		   if(des.getClave().intValue() == precio.getCve_destino().intValue()) {
	  			   try {
		  			  double venta = calculadora.getUmedida() == 1 ? precio.getPrecio().floatValue()  * calculadora.getCantidad()
	                          : precio.getPrecio().floatValue()  * 1000 * calculadora.getCantidad();
		  			  
		  			  des.setpUnitario(precio.getPrecio().doubleValue());
		  			  des.setfPrecio(precio.getFecha_act());
		  			  des.setVenta(venta);
		  			  
		  			  pDestinos.put(venta * (-1), des);
	  			   } catch(Exception ex) {
	  				   ex.printStackTrace();
	  			   }
	  		   }
	  		}
	  	}
	  		  	  
	  	
	  	int idx=0;
	  	for(Map.Entry<Double,Destino> entry : sDestinos.entrySet()) {
	  		
  			  if(idx >= 12) { //aSakbeNumMax) {
  				  //System.out.println("num max peticiones");
  				  break;
  			  }
  			  
		  	  Destino destino = entry.getValue();
		  	  Double venta = destino.getVenta();
		  	  		  	  
		  	  System.out.println("destino=> " + destino.getDestino());
		  	  try {
		  		List<Ruta> ruta = getRutaDestino(calculadora, destino, aSakbeUrlBaseRuta, aSakbeUrlBaseRutaPin, aSakbeToken);
		  		ruta.get(0).setDestino(destino.getDestino());
		  		ruta.get(0).setLat(destino.getLat().floatValue());
		  		ruta.get(0).setLng(destino.getLng().floatValue());
		  		ruta.get(0).setVenta(venta);
		  		ruta.get(0).setpUnitario(destino.getpUnitario());
		  		ruta.get(0).setfPrecio(destino.getfPrecio());
		  		
		  		double cCombustible = (ruta.get(0).getLong_km().floatValue() / 3) * 19.6;
		  		ruta.get(0).setpCombustible(cCombustible);
		  		
		  		double costo = ruta.get(0).getCosto_caseta().doubleValue() + cCombustible;
		  		sRutas.put(costo- venta ,ruta);		  		
		  		idx++;
		  		
		  	  } catch (Exception e) {						
		  		  e.printStackTrace();
		  		  
			  }
		  	  
	  	}
	  	  
	  	return sRutas;
	}
	
		
	private static List<Ruta> getRutaDestino(Calculadora calculadora, Destino destino, String aSakbeUrlBaseRuta, String aSakbeUrlBaseRutaPin, String aSakbeToken) throws Exception{
		
		String urlRuta = calculadora.getUtipo() == 1 ? aSakbeUrlBaseRuta: aSakbeUrlBaseRutaPin;
		urlRuta= urlRuta.replaceAll("PARAM_key", aSakbeToken);
		
		if(calculadora.getUtipo() == 1) {
			urlRuta= urlRuta.replaceAll("PARAM_dest_i", String.valueOf(calculadora.getIdDes()));
		} else {
			urlRuta= urlRuta.replaceAll("PARAM_id_i", String.valueOf(calculadora.getId_i()));
			urlRuta= urlRuta.replaceAll("PARAM_source_i", String.valueOf(calculadora.getSource_i()));
			urlRuta= urlRuta.replaceAll("PARAM_target_i", String.valueOf(calculadora.getTarget_i()));
		}
		
		
		urlRuta= urlRuta.replaceAll("PARAM_id_f", String.valueOf(destino.getId_f()));
		urlRuta= urlRuta.replaceAll("PARAM_source_f", String.valueOf(destino.getSource_f()));
		urlRuta= urlRuta.replaceAll("PARAM_target_f", String.valueOf(destino.getTarget_f()));
		urlRuta= urlRuta.replaceAll("PARAM_veh", String.valueOf(calculadora.getIdVeh()));
		urlRuta= urlRuta.replaceAll("PARAM_ejes", String.valueOf(calculadora.getEjes()));
		
		//System.out.println(urlRuta);
		
		 final HttpParams httpParams = new BasicHttpParams();
	     HttpConnectionParams.setConnectionTimeout(httpParams, 30000);
		    
						
		DefaultHttpClient httpClient = new DefaultHttpClient(httpParams);
		HttpGet getRequest = new HttpGet(urlRuta);
		getRequest.addHeader("accept", "application/json");
		HttpResponse response = httpClient.execute(getRequest);
		if (response.getStatusLine().getStatusCode() != 200) {
			throw new RuntimeException("Error al recuperar los calculos del destino <" 
					+ destino.getDestino() + ">: Código : "  + response.getStatusLine().getStatusCode());
		}
		
		ObjectMapper mapper = new ObjectMapper();
		TypeReference<List<Ruta>> typeReference = new TypeReference<List<Ruta>>(){};
		List<Ruta> ruta = mapper.readValue(new InputStreamReader((response.getEntity().getContent())), typeReference);
		httpClient.getConnectionManager().shutdown();
		return ruta;	
	}
	
	private static double distance(double lat1, double lon1, double lat2, double lon2, char unit) {
	      double theta = lon1 - lon2;
	      double dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta));
	      dist = Math.acos(dist);
	      dist = rad2deg(dist);
	      dist = dist * 60 * 1.1515;
	      if (unit == 'K') {
	        dist = dist * 1.609344;
	      } else if (unit == 'N') {
	        dist = dist * 0.8684;
	        }
	      return (dist);
    }

    private static double deg2rad(double deg) {
      return (deg * Math.PI / 180.0);
    }


    private static double rad2deg(double rad) {
      return (rad * 180.0 / Math.PI);
    }
    
    @RequestMapping(value={"cultivos"}, method = RequestMethod.POST) 
    private List<Cultivo> getCultivos() {
    	return cultivoDao.findAll();
    }
    
    @RequestMapping(value={"catVehiculos"}, method = RequestMethod.POST) 
    private List<CategoriaVehiculo> getCVehiculos() {
    	return catVehDao.getCatVehiculos();
    }
    
    @RequestMapping(value={"vehiculos"}, method = RequestMethod.POST) 
    private List<Vehiculo> getVehiculos() {
    	return vehiculoDao.getVehiculos(); 
    }
    
    @RequestMapping(value={"ejes"}, method = RequestMethod.POST) 
    private List<Ejes> getEjes() {
    	return ejesDao.findAll();
    }
    
    @RequestMapping(value={"precios"}, method = RequestMethod.GET) 
    private List<Precios>  getPreciosCultivo() {
    	return preciosDao.getPreciosCultivo(9076);
    }
}
