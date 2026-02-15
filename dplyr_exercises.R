# Load the tidyverse package
library(tidyverse)

#Load dataset
data(iris)

# ==========================================
# 1. SELECT Function: Choosing columns
# ==========================================
# Select specific columns
iris %>%
  select(Sepal.Length, Sepal.Width)

# ==========================================
# 2. SLICE Function: Selecting rows by position
# ==========================================
# Select first 15 rows
iris %>%
  slice(1:15)

# Select specific rows by index
iris %>%
  slice(c(1, 4, 6, 9))

# Pipe chain: Select columns first, then slice rows
iris %>%
  select(Sepal.Length, Sepal.Width) %>%
  slice(1:5)

# --- slice_min() and slice_max() ---

# Numeric: Get rows with smallest/largest Sepal.Length
iris %>%
  slice_min(order_by = Sepal.Length, n = 10)

iris %>%
  slice_max(order_by = Sepal.Length, n = 10)

# Character: Get rows based on alphabetical order of Species
iris %>%
  slice_min(order_by = Species, n = 10)

iris %>%
  slice_max(order_by = Species, n = 10)

# ==========================================
# 3. DISTINCT Function: Unique values
# ==========================================
# Find unique values in the Species column
iris %>%
  distinct(Species)

# ==========================================
# 4. ARRANGE Function: Sorting data
# ==========================================
# Sort by Sepal.Width in ascending order
iris %>%
  arrange(Sepal.Width) 

# Sort by Sepal.Width (ascending), then Sepal.Length (ascending)
iris %>%
  arrange(Sepal.Width, Sepal.Length)  

# Sort by Sepal.Length in descending order
iris %>%
  arrange(desc(Sepal.Length))

# ==========================================
# 5. SUMMARISE Function: Summary statistics
# ==========================================
# Calculate mean, median, and standard deviation
iris %>%
  summarise(mean = mean(Sepal.Length),
            median = median(Sepal.Length),
            sd = sd(Sepal.Length))

# ==========================================
# 6. GROUP_BY Function: Grouping data
# ==========================================
# Group data by Species
df <- iris %>%
  group_by(Species)
print(df, n = 150) 

# Adding a dummy grouping variable for demonstration
extra <- c(rep("a", 50), rep("b", 50), rep("c", 50)) 
iris$extra <- extra

# Group by multiple variables
iris %>%
  group_by(Species, extra)

# --- Using group_by() with summarise() ---
# Calculate means for each group
iris %>% 
  group_by(Species) %>% 
  summarise(Sepal.Length_Mean = mean(Sepal.Length),
            Sepal.Width_Mean = mean(Sepal.Width))

# ==========================================
# 7. FILTER Function: Filtering rows
# ==========================================
# Simple condition
iris %>% 
  filter(Sepal.Length < 5)

# AND condition (both must be true)
iris %>% 
  filter(Sepal.Length < 5, Sepal.Width > 3)

# OR condition (at least one must be true)
iris %>% 
  filter(Sepal.Length < 5 | Sepal.Width > 3)

# Combined usage: Filter then Select
iris %>% 
  filter(Sepal.Length < 5, Sepal.Width > 3) %>% 
  select(Sepal.Length, Sepal.Width)

# Complex Chain: Filter -> Select -> Group -> Summarise
iris %>% 
  filter(Sepal.Length < 5, Sepal.Width > 3) %>% 
  select(Sepal.Length, Sepal.Width, Species) %>% 
  group_by(Species) %>% 
  summarise(Sepal.Length_Mean = mean(Sepal.Length),
            Sepal.Width_Mean = mean(Sepal.Width))

# ==========================================
# 8. MUTATE Function: Creating/Modifying columns
# ==========================================
# Modify an existing column (overwriting)
iris %>% 
  mutate(Sepal.Length = log(Sepal.Length))

# Create a new column
iris %>% 
  mutate(Sepal.Length_Log = log(Sepal.Length))

# Changing variable types
class(iris$Species) # currently factor

df2 <- iris %>% 
  mutate(Species = as.character(Species))

class(df2$Species) # now character

# --- Conditional Mutation (mutate_if) ---
# Apply function only to numeric columns
iris %>% 
  mutate_if(is.numeric, function(x){x^2})

iris %>% 
  mutate_if(is.numeric, log)
