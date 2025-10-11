# From the Deep

In this problem, you'll write freeform responses to the questions provided in the specification.

## Random Partitioning

There are trade-offs for Random Partitioning:

**Pros:** Random Partitioning is not biased in partitioning data. Each part of the data is randomly and fairly partitioned, and selected.
**Contra:** It might be better for research purposes to have a sorted group of data, based on some criteria. Although Random Partitioning avoids any pattern for partitioning, the resulted groups might include different mixed data. It might be better to have a sorted group of data for each boats, so that we can easily select the specific portion of data we need from a specific group.

## Partitioning by Hour

**Pros:** Partitioning by Hour would allow us to select a subset of data we need much more easier, since it is already sorted based on a specific criteria, in this case, `Hour`. So, we don't have the problem of mixed data in each boats that we had earlier.
**Contra:** It is worth noting, that if we were to partition our data by hour, we might end up with some empty boats. Meaning some of the boats will not receive any observations  at all. (Since most of the distribution are in the evening and early morning hours.)

## Partitioning by Hash Value

**Pros:** The observations will be evenly distributed. Since a single observation is no more likely to be assigned one hash value than another, which means any single observation could be sent to any one of the three available boats.
**Contra:** The hash values might not be as easy as timesptamps to understand and do analysis on.
