heater_tube_d = 24.5;
bracket_height = 12;

$fn=150;

linear_extrude(height = bracket_height) {
  import(file = "heater-towel-bracket.svg");
}