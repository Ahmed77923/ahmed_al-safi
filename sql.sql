-- Display all patients with their gender and date of birth
SELECT name, gender, dob
FROM patients;


-- List all doctors and their specializations
SELECT name, specialization
FROM doctors;

-- Show all visits that occurred in the last 30 days
SELECT *
FROM visit
WHERE visit_date >= CURRENT_DATE - INTERVAL '30 days';


-- Display all visits handled by a specific doctor (e.g., Doctor_5)
SELECT v.*
FROM visit v
JOIN doctors d ON v.doctor_id = d.doctor_id
WHERE d.name = 'Doctor_5';



-- Count the total number of patients in the hospital
SELECT COUNT(*) AS total_patients
FROM patients;


-- Display patient name, doctor name, and visit date for every visit
SELECT
  p.name AS patient_name,
  d.name AS doctor_name,
  v.visit_date
FROM visit v
JOIN patients p ON v.patient_id = p.patient_id
JOIN doctors d ON v.doctor_id = d.doctor_id;


-- Show a list of patients and the doctors who treated them
SELECT DISTINCT
  p.name AS patient_name,
  d.name AS doctor_name
FROM visit v
JOIN patients p ON v.patient_id = p.patient_id
JOIN doctors d ON v.doctor_id = d.doctor_id;



-- Display visit details, including treatment cost
SELECT
  v.visit_id,
  v.visit_date,
  t.cost
FROM visit v
JOIN treatment t ON v.visit_id = t.visit_id;

-- List all visits where the treatment cost is greater than 300
SELECT
  v.visit_id,
  v.visit_date,
  t.cost
FROM visit v
JOIN treatment t ON v.visit_id = t.visit_id
WHERE t.cost > 300;


-- Show all patients who were treated by doctors in cardiology
SELECT DISTINCT
  p.name AS patient_name
FROM visit v
JOIN patients p ON v.patient_id = p.patient_id
JOIN doctors d ON v.doctor_id = d.doctor_id
WHERE d.specialization = 'Cardiology';
