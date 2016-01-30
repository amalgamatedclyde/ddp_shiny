##Polynomial Explorer

The **Polynomial Explorer** is a Shiny Application that displays polynomials with normally-distributed noise. 

It accepts an input from the user that represents the user's guess at the the degree of the polynomial shown. The user can change the amount of noise added to the polynomial. 

The application uses R's lm function with the 'poly' argument to build a linear model. The residual sum of squares for that curve is displayed. The user can toggle the display of the fitted curve and the true function without noise.
