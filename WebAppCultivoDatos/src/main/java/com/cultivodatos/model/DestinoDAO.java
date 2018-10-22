package com.cultivodatos.model;

import java.util.List;

import javax.transaction.Transactional;
import org.springframework.data.repository.CrudRepository;

@Transactional
public interface DestinoDAO extends CrudRepository<Destino, Long> {
	
	public List<Destino> findAll();
}
