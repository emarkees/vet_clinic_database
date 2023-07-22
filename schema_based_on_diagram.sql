 CREATE TABLE medical_histories_has_treatments (
    medical_history_id INT REFERENCES medical_histories(id),
    treatment_id INT REFERENCES treatments(id),
    );

CREATE TABLE treatments (
    id INT GENERATED ALWAYS AS IDENTITY,
    type VARCHAR(30),
    name VARCHAR(30),
    PRIMARY KEY(id),
);

CREATE TABLE medical_histories (
    id INT GENERATED ALWAYS AS IDENTITY,
    admitted_at TIMESTAMP,
    patient_id INT,
    status VARCHAR(30),
    PRIMARY KEY(id),
    FOREIGN KEY(patient_id) REFERENCES patients(id)
);

CREATE TABLE patients(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(20),
  date_of_birth DATE,
  PRIMARY KEY(id)
);

CREATE TABLE invoices(
  id INT GENERATED ALWAYS AS IDENTITY,
  total_amountsql DECIMAL,
  generated_at TIMESTAMP,
  generated_at TIMESTAMP,
  medical_history_id INT
  PRIMARY KEY(id)
);

CREATE TABLE invoice_items (
  id INT,
  unite_price DECIMAL,
  quantity INT,
  total_price DECIMAL,
  invoice_id INT,
  treatment_id INT,
  PRIMARY KEY(id),
  FOREIGN KEY(invoice_id) REFERENCES invoices(id),
  FOREIGN KEY(treatment_id) REFERENCES treatments(id),
);


-- FOREIGN KEY for medical_history_id in invoices
ALTER TABLE invoices
ADD CONSTRAINT fk_invoices_medical_history
FOREIGN KEY (medical_history_id)
REFERENCES medical_histories(id);

-- FOREIGN KEY for medical_history_id in medical_histories_has_treatments
ALTER TABLE medical_histories_has_treatments
ADD CONSTRAINT fk_med_histories_treatments_medical_history
FOREIGN KEY (medical_history_id)
REFERENCES medical_histories(id);

-- FOREIGN KEY for treatment_id in medical_histories_has_treatments
ALTER TABLE medical_histories_has_treatments
ADD CONSTRAINT fk_med_histories_treatments_treatment
FOREIGN KEY (treatment_id)
REFERENCES treatments(id);


CREATE INDEX ON medical_histories (patient_id);
CREATE INDEX ON invoices (medical_history_id);
CREATE INDEX ON invoice_items (invoice_id);
CREATE INDEX ON invoice_items (treatment_id);
CREATE INDEX ON medical_histories_has_treatments (medical_history_id);
CREATE INDEX ON medical_histories_has_treatments (treatment_id);