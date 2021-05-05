import matplotlib.pyplot as plt

polls = [
    ("Flask vs. Django", 60, 19),
    ("Who will win the election?", 15, 36),
    ("Python vs. Java", 26, 40),
    ("Mac vs. Windows", 25, 34),
    ("What is the most popular type of graph?", 20, 13),
    ("Who is the podcasting king?", 11, 6),
]

figure = plt.figure()
axes = figure.add_subplot(1, 1, 1)

axes.bar(
    range(len(polls)),
    [poll[1] for poll in polls]
)

plt.show()
