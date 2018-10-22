package com.cultivodatos.model;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.StoredProcedureQuery;

public class CategoriaVehiculoDAOImpl implements CategoriaVehiculoDAOCustom{
	
	@PersistenceContext
    private EntityManager em;
	
	@Override
    public List<CategoriaVehiculo> getCatVehiculos() {
        StoredProcedureQuery _sp = em.createNamedStoredProcedureQuery("_lstCatVehiculos");
        return _sp.getResultList();
    }

}
