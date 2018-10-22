package com.cultivodatos.model;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

public interface EjesDAO extends CrudRepository<Ejes, Long>{
	public List<Ejes> findAll();
}