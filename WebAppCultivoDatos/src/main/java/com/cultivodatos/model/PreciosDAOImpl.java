package com.cultivodatos.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.ParameterMode;
import javax.persistence.PersistenceContext;
import javax.persistence.StoredProcedureQuery;

public class PreciosDAOImpl implements PreciosDAOCustom {

	@PersistenceContext
    private EntityManager em;
	
	@Override
    public List<Precios> getPreciosCultivo(int cveCultivo) {
        StoredProcedureQuery _sp = em.createStoredProcedureQuery("_spGetPreciosCultivo");
        _sp.registerStoredProcedureParameter(0,Integer.class, ParameterMode.IN);
        _sp.setParameter(0, cveCultivo);
        
        Object [] results = _sp.getResultList().toArray();
        List<Precios> precios = new ArrayList<Precios>();
        
        for(Object res : results) {
        	Precios precio = new Precios();
        	Object[] tmp = (Object[])res;
        	precio.setCve_cultivo((int)tmp[0]);
        	precio.setCve_destino((int)tmp[1]);
        	precio.setPrecio((float)tmp[2]);
        	precio.setMin_precio((float)tmp[3]);
        	precio.setMax_precio((float)tmp[4]);
        	precio.setFecha_act((Date)tmp[5]);        	
        	precios.add(precio);
        }         
         
        return precios; 
    }
}