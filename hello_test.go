package main

import "testing"

// test function names begin with uppercase Test
func TestMessage(t *testing.T) {
	project := new(Project)
	project.PushedAt = "now"
	project.Name = "TestProject"
	msg := Message(project)
	if msg != "<p>TestProject: Latest commit: now</p>" {
		t.Errorf("Incorrect message: %s", msg)
	}
}

func TestMessageLackOfPushAt(t *testing.T) {
	project := new(Project)
	project.Name = "TestProject"
	msg := Message(project)
	if msg != "<p>TestProject: Latest commit: </p>" {
		t.Errorf("Incorrect message: %s", msg)
	}
}

func TestMessageLackOfName(t *testing.T) {
	project := new(Project)
	project.PushedAt = "now"

	msg := Message(project)
	if msg != "<p>: Latest commit: now</p>" {
		t.Errorf("Incorrect message: %s", msg)
	}
}

func TestFailCase(t *testing.T) {
	project := new(Project)
	project.PushedAt = "sssss"

	msg := Message(project)
	if msg != "<p>: Latest commit: now</p>" {
		t.Errorf("Incorrect message: %s", msg)
		t.Fail() // Bắt lỗi ở đây
	}
}
