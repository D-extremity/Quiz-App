List<Map<String, String>> questions = [
  {
    "q": "What is the chemical symbol for water?",
    "o1": "A) HO",
    "o2": "B) H2O",
    "o3": "C) O2",
    "o4": "D) CO2",
  },
  {
    "q": "What planet is known as the Red Planet?",
    "o1": "A) Earth",
    "o2": "B) Mars",
    "o3": "C) Jupiter",
    "o4": "D) Saturn",
  },
  {
    "q": "What force keeps us on the ground?",
    "o1": "A) Magnetism",
    "o2": "B) Gravity",
    "o3": "C) Friction",
    "o4": "D) Electromagnetic force",
  },
  {
    "q": "What is the boiling point of water?",
    "o1": "A) 0°C",
    "o2": "B) 50°C",
    "o3": "C) 100°C",
    "o4": "D) 150°C",
  },
  {
    "q": "What gas do plants absorb from the atmosphere?",
    "o1": "A) Oxygen",
    "o2": "B) Nitrogen",
    "o3": "C) Carbon Dioxide",
    "o4": "D) Helium",
  },
  {
    "q": "What is the center of an atom called?",
    "o1": "A) Electron",
    "o2": "B) Proton",
    "o3": "C) Neutron",
    "o4": "D) Nucleus",
  },
  {
    "q": "What is the primary source of energy for the Earth?",
    "o1": "A) The Moon",
    "o2": "B) The Sun",
    "o3": "C) Wind",
    "o4": "D) Water",
  },
  {
    "q": "Which planet is closest to the Sun?",
    "o1": "A) Venus",
    "o2": "B) Earth",
    "o3": "C) Mercury",
    "o4": "D) Mars",
  }
];

final List<String> answer = [
  "B) H2O",
  "B) Mars",
  "B) Gravity",
  "C) 100°C",
  "C) Carbon Dioxide",
  "D) Nucleus",
  "B) The Sun",
  "C) Mercury",
];

int getMarks(List<String?> submittedList) {
  int counter = 0;
  if (submittedList.length != answer.length &&
      submittedList.length < answer.length) {
    for (int i = 0; i < submittedList.length; i++) {
      if (answer[i] == submittedList[i]) {
        counter++;
      }
    }
    return counter;
  }
  for (int i = 0; i < answer.length; i++) {
    if (answer[i] == submittedList[i]) {
      counter++;
    }
  }
  return counter;
}
