package com.cultivodatos.model;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.StoredProcedureQuery;

public class VehiculoDAOImpl implements VehiculoDAOCustom {

	@PersistenceContext
    private EntityManager em;
	
	@Override
    public List<Vehiculo> getVehiculos() {
        StoredProcedureQuery _sp = em.createNamedStoredProcedureQuery("_lstVehiculos");
        return _sp.getResultList();
    }
}
