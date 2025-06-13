package utils

import "testing"

func TestAdd(t *testing.T) {
	got := Add(5, 3)
	want := 8
	if got != want {
		t.Errorf("Add(5, 3) = %d; expected %d", got, want)
	}
}

func TestSubtract(t *testing.T) {
	got := Subtract(10, 4)
	want := 6
	if got != want {
		t.Errorf("Subtract(10, 4) = %d; expected %d", got, want)
	}
}

func TestMultiply(t *testing.T) {
	got := Multiply(3, 7)
	want := 21
	if got != want {
		t.Errorf("Multiply(3, 7) = %d; expected %d", got, want)
	}
}

func TestDivide(t *testing.T) {
	t.Run("successful division", func(t *testing.T) {
		got, err := Divide(10.0, 2.0)
		want := 5.0

		if err != nil {
			t.Errorf("unexpected error: %v", err)
		}
		if got != want {
			t.Errorf("Divide(10.0, 2.0) = %f; expected %f", got, want)
		}
	})

	t.Run("zero division", func(t *testing.T) {
		_, err := Divide(10.0, 0)
		if err == nil {
			t.Errorf("it was expected an error, but none thrown.")
		}
	})
}