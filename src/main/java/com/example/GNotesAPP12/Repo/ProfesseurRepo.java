package com.example.GNotesAPP12.Repo;

import com.example.GNotesAPP12.Model.Professeur;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProfesseurRepo extends JpaRepository<Professeur, String> {
}