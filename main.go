package main

import (
	"context"
  "go-demo/utils"
	"github.com/labstack/echo/v4"
)

func main() {
	e := echo.New()

	e.GET("/", func(c echo.Context) error {
		sum := utils.Add(5, 3)

		component := hello("World", sum)

		c.Response().Header().Set(echo.HeaderContentType, echo.MIMETextHTML)
		return component.Render(context.Background(), c.Response().Writer)
	})

	e.Logger.Fatal(e.Start(":3000"))
}