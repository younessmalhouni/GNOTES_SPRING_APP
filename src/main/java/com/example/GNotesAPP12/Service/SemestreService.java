package com.example.GNotesAPP12.Service;

import com.example.GNotesAPP12.Model.Semestre;
import com.example.GNotesAPP12.Repo.SemestreRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SemestreService {

    @Autowired
    private SemestreRepo semestreRepo;

    public List<Semestre> getAllSemestres() {
        return semestreRepo.findAll();
    }

}
