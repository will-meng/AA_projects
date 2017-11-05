// const Faker = require('fakergem');

const Student = function(fname, lname) {
  this.fname = fname;
  this.lname = lname;
  this.courses = [];
};

Student.prototype.name = function () {
  return `${this.fname} ${this.lname}`;
};

Student.prototype.enroll = function (course) {
  if (!this.courses.includes(course)) {
    this.courses.push(course);
    course.students.push(this);
  }
};

Student.prototype.courseload = function () {
  const result = {};
  this.courses.forEach(function(course) {
    if (!result[course.dept]) {
      result[course.dept] = 0;
    }
    result[course.dept] += course.credits;
  });
  return result;
};

const Course = function(name, dept, credits) {
  this.name = name;
  this.dept = dept;
  this.credits = credits;
  this.students = [];
};

Course.prototype.addStudent = function(student) {
  student.enroll(this);
};

const matt = new Student('matt', 'dunno');
const js = new Course('JS 101', 'CS', 5);
const ruby = new Course('Ruby 101', 'CS', 4);
const emp = new Course('Empathy', 'Hum', 2);

js.addStudent(matt);
