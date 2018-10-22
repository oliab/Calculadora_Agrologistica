package com.cultivodatos.model;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

public interface CultivoDAO extends CrudRepository<Cultivo, Long>{
	public List<Cultivo> findAll();
}
