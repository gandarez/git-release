package git_test

import (
	"testing"

	"github.com/gandarez/git-release/pkg/git"

	"github.com/stretchr/testify/assert"
)

func TestPrintTag(t *testing.T) {
	tag := git.PrintTag("1.2.3")

	assert.Equal(t, "v1.2.3", tag)
}
