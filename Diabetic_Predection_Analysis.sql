use psyliq
drop table  psyliq.diabetes_prediction;
select * from practice_1 limit 10;
rename table practice_1 to Diabetes_prediction;

select * from Diabetes_prediction limit 5;
alter table Diabetes_prediction rename column ï»¿EmployeeName  to employeename;



# 1. Retrieve the Patient_id and ages of all patients.
select Patient_id ,age from Diabetes_prediction;






# 2. Select all female patients who are older than 40.
select gender ,age from Diabetes_prediction where 
gender = "female" and age > 40 ;







# 3 Calculate the average BMI of patients.
 select avg(bmi) from Diabetes_prediction;
 


# 4. List patients in descending order of blood glucose levels.
select Patient_id , employeename, blood_glucose_level from Diabetes_prediction
order by blood_glucose_level desc ;

# 5. Find patients who have hypertension and diabetes.
select patient_id , employeename ,hypertension,diabetes from Diabetes_prediction where hypertension = 1 and diabetes =1;

# 6. Determine the number of patients with heart disease.
select count(heart_disease) from Diabetes_prediction where heart_disease = 1 ;

# 7. Group patients by smoking history and count how many smokers and nonsmokers there are.
select smoking_history , count(patient_id) from Diabetes_prediction
where smoking_history != " never" group by smoking_history ;

# 8. Retrieve the Patient_ids of patients who have a BMI greater than the average BMI
select Patient_id , employeename from Diabetes_prediction 
where bmi > (select avg(bmi) from Diabetes_prediction);


# 9.  #Find the patient with the highest HbA1c level and the patient with the lowest HbA1clevel.

(select Patient_id, employeename ,HbA1c_level  from Diabetes_prediction where HbA1c_level = ( select min(HbA1c_level) from Diabetes_prediction) order by HbA1c_level desc limit 1)
union all
(select Patient_id, employeename ,HbA1c_level  from Diabetes_prediction where HbA1c_level = ( select max(HbA1c_level) from Diabetes_prediction) order by HbA1c_level desc limit 1) ;
 
#  10. Calculate the age of patients in years (assuming the current date as of now).
select Patient_id , age  as Patient_years from Diabetes_prediction ;

# 11. Rank patients by blood glucose level within each gender group.
select Patient_id ,gender ,blood_glucose_level,rank() 
over( partition by gender order by blood_glucose_level) as glucose_level_by_gender from Diabetes_prediction;

# 12. Update the smoking history of patients who are older than 50 to "Ex-smoker."
update Diabetes_prediction set smoking_history = 'Ex-smoker' where age >50 ; 
select Patient_id,age,smoking_history from Diabetes_prediction  where age >50 limit 20;



# 13. Insert a new patient into the database with sample data.
 insert into Diabetes_prediction
 values ("praful","PD2001",'Male',23,0,0,"never",22,22.8,7,100),
 ("yash","YK2001",'Male',25,1,1,"never",24,25.8,7.7,120 );
 select * from Diabetes_prediction where employeename in ('praful' , 'yash' )
 
 
# 14. Delete all patients with heart disease from the database.
delete from Diabetes_prediction where heart_disease =1 ;
select * from Diabetes_prediction where heart_disease =1 ;



# 15. Find patients who have hypertension but not diabetes using the EXCEPT operator.
select patient_id,employeename,hypertension,diabetes from Diabetes_prediction where
hypertension = 1 and diabetes = 0;

 
# 16. Define a unique constraint on the "patient_id" column to ensure its values are unique.

alter table Diabetes_prediction add constraint Patient_id 
unique(Patient_id)

# 17. Create a view that displays the Patient_ids, ages, and BMI of patients.
  
  create view  p_id_info 
  as select patient_id , age , bmi from Diabetes_prediction;
  
# 18. Suggest improvements in the database schema to reduce data redundancy and improve data integrity.

  # >>> By Ensuring  that database is normalized . Using of  primary keys and foreign keyto establishing relationships.Eliminate redundant columns; split tables if needed. 
  # >>> Consider using composite keys when appropriate. Use appropriate data types and sizes.Enforce data consistency with validation rules and check constraints.
  # >>> Create views to simplify complex queries. Conduct routine maintenance for optimal performance.


# 19. Explain how you can optimize the performance of SQL queries on this dataset.
   # >>> By using indexing,
   # >>> using where clause,
   # >>> limiting the rows,
   # >>> optimizing joins ,
   # >>> using aggregate functions