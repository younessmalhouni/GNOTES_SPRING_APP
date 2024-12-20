package com.example.GNotesAPP12.Repo;

import com.example.GNotesAPP12.Model.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface ElementRepo extends JpaRepository<Element, String> {

}
