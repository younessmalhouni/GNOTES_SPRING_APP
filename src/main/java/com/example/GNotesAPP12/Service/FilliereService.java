package com.example.GNotesAPP12.Service;
import com.example.GNotesAPP12.Model.Filliere;
import com.example.GNotesAPP12.Repo.FilliereRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FilliereService {

    @Autowired
    private FilliereRepo filliereRepo;

    public List<Filliere> getAllFillieres() {
        return filliereRepo.findAll();
    }

    public Filliere getFilliereById(String id) {
        return filliereRepo.findById(id).orElse(null);
    }

    public void saveFilliere(Filliere filliere) {
        filliereRepo.save(filliere);
    }

    public void deleteFilliere(String id) {
        filliereRepo.deleteById(id);
    }
    }
