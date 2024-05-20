coba <- 1
coba

coba_2 <- 1
coba_2

# Use different object name to avoid rewriting the previous storing
# process

coba <- 1
coba

coba <- 2
coba
# ------------------------- #
# There are several object types

# 1. Numeric and Vectors
num_type <- c(1,2,3)                # Create series 1 to 3 by 1
num_type <- seq(from=1, to=3, by=1) # You may use specific funtion
num_type
class(num_type)        # Check the object class
is.numeric(num_type)   # You can also has Boolean data to checking
is.matrix(num_type)    # You can also check the false statement
is.na(num_type)        # Checking for missing values
!is.na(num_type)       # Checking there is no missing values
length(num_type)       # Checking the vector length
# ------------------------- #

# 2. Matrices
# To create matrix you need to define the row and col dimension
mat_type <- matrix(seq(1, 9, 1), nrow = 9, ncol = 1)
mat_type
mat_type <- matrix(seq(1, 9, 1), nrow = 1, ncol = 9)
mat_type
mat_type <- matrix(seq(1, 9, 1), nrow = 3, ncol = 3)
mat_type

is.matrix(mat_type)  # Checking the object class
dim(mat_type)        # Checking the matrix dimension

# Matrix elements can be defined or searched using element position
# Element position define using [,]
# To locate element A[2,1] you need define mat_type[2,1]
mat_type[2,1]; mat_type[2,2]; mat_type[1,1]

# Matrix entry method can be used byrows or bycolumns
# Default entry is filled by columns.
# To fill byrows you need to define byrows = TRUE options
# in matrix options (default: byrows = FALSE)
mat_type <- matrix(seq(1, 9, 1), nrow = 3, ncol = 3,
                   byrow = FALSE)
mat_type

mat_type <- matrix(seq(1, 9, 1), nrow = 3, ncol = 3,
                   byrow = TRUE)
mat_type

# There are several matrix form that can be generated using basic function:
mat_diag <- diag(1, nrow = 3, ncol = 3)  # Create 3x3 diagonal matrix 
mat_diag

# There are also several functions such as:
# det()   -> determinant matrix
# solve() -> inverse matrix
# t()     -> Transpose matrix
# %*%     -> dot product matrix
# *       -> Hadamard product matrix
# /       -> Hadamard division matrix
# upper.tri   -> extract upper triangular matrix components
# lower.tri   -> extract lower triangular matrix components
# diag()      -> extract diagonal elements components
# kronecker() -> Compute Kronecker product of 2 matrices

# ------------------------- #
# 3. Data Frame

df_type <- data.frame(seq(1, 9, 1))
colnames(df_type)  <- "Sequence"
df_type

df_type_2 <- data.frame(matrix(seq(1, 9, 1), nrow = 3, ncol = 3,
                   byrow = TRUE))
df_type_2
colnames(df_type_2) <- c("Col_1", "Col_2", "Col_3")
rownames(df_type_2) <- c("Row_1", "Row_2", "Row_3")
df_type_2

df_type
#df_type$Sequence_2  <- seq(0.1, 1, 0.1)
df_type$Sequence_2  <- seq(0.1, 0.9, 0.1)
df_type

df_type$Sequnce_3 <- df_type$Sequence + df_type$Sequence_2
df_type

df_type$Sequnce_4 <- rnorm(n = length(df_type$Sequence), sd=1, mean=0) * df_type$Sequence_2
df_type

df_type$Sequnce_5 <- runif(n = length(df_type$Sequence), min=-1, max=1) * df_type$Sequence_2
df_type

df_type$Sequnce_6 <- sample(x=100, size=length(df_type$Sequence), replace=F) * df_type$Sequence
df_type

# ------------------------- #
# Ploting The Data Frame

plot(x=df_type$Sequence, y=df_type$Sequence_2)                # Scatter Plot
plot(x=df_type$Sequence, y=df_type$Sequence_2, type = "b")    # Line + dot plot
plot(x=df_type$Sequence, y=df_type$Sequence_2, type = "h")    # Bar plot
plot(x=df_type$Sequence, y=df_type$Sequence_2, type = "l")    # Line plot

# Change the color from black into red 
plot(x=df_type$Sequence, y=df_type$Sequence_2, type = "b", col="red")    

# Change Line thickness 
plot(x=df_type$Sequence, y=df_type$Sequence_2, type = "b", col="red", lwd=3)    

# Change Line type 
plot(x=df_type$Sequence, y=df_type$Sequence_2, type = "l", col="red", lty=2)

# Change Dot type 
plot(x=df_type$Sequence, y=df_type$Sequence_2, type = "b", col="red", lwd=4, pch=24)

# Add Title and subtitle, Change Axes Title 
plot(x=df_type$Sequence, y=df_type$Sequnce_5, type = "b", col="red", lwd=4, pch=24,
     main="Sequntial Plot", sub="Just Some Sequence", xlab="Sequences", ylab="randomized sequence")

# Add lines or second plot on the existing plot 
plot(x=df_type$Sequence, y=df_type$Sequnce_5, type = "b", col="red", lwd=4, pch=24,
     main="Sequntial Plot", sub="Just Some Sequence", xlab="Sequences", ylab="randomized sequence")
par(new = TRUE)
abline(a=0, b=0, col="green", lwd=3, lty=2)

# Or you can use following
plot(x=df_type$Sequence, y=df_type$Sequnce_5, type = "b", col="red", lwd=4, pch=24,
     main="Sequntial Plot", sub="Just Some Sequence", xlab="Sequences", ylab="randomized sequence")
abline(a=0, b=0, col="blue", lwd=3, lty=2, new=TRUE)

# Delete the box and other information
plot(x=df_type$Sequence, y=df_type$Sequnce_5, type = "b", col="red", lwd=4, pch=24,
     axes=FALSE, xlab="", ylab="")
abline(a=0, b=0, col="blue", lwd=3, lty=2, new=TRUE)

# ------------------------- #
# For Loops
# For Loops used for iterative process

empty_mat  <-  matrix(NA, ncol = 4, nrow = 4)
empty_mat

# For Loops by element matrix

for (i in 1:(nrow(empty_mat)*ncol(empty_mat))) {
  empty_mat[i] <- i + 1
}

empty_mat

empty_mat_2  <-  matrix(NA, ncol = 4, nrow = 4)
empty_mat_2

# For Loops by element matrix

count = 1
for (j1 in 1:nrow(empty_mat_2)) {
  for (j2 in 1:ncol(empty_mat_2)) {
    count  =  count + 1
    empty_mat_2[j1,j2] <- count
  }
}

empty_mat_2
t(empty_mat_2)
