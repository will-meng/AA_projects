class Employee
  attr_reader :salary, :name

  def initialize(name, title, salary, boss = nil)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
    @boss.employees << self unless boss.nil?
  end

  def bonus(multiplier)
    @salary * multiplier
  end

end

class Manager < Employee
  attr_reader :employees

  def initialize(name, title, salary, boss = nil)
    @employees = []
    super
  end

  def bonus(multiplier)
    base = all_employees.reduce(0) do |sum, emp|
      sum + emp.salary
    end
    base * multiplier
  end

  protected

  def all_employees
    result = []

    @employees.each do |emp|
      if emp.is_a?(Manager)
        result += [emp] + emp.all_employees
      else
        result += [emp]
      end
    end

    result
  end
end

ned = Manager.new("Darren", "Big Boss", 1_000_000)
darren = Manager.new("Darren", "Big Boss", 78_000, ned)
shawna = Employee.new("Shawna", "TA", 12_000, darren)
david = Employee.new("David", "TA", 10_000, darren)
p ned.bonus(5)
