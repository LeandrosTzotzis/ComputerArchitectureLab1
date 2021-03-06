# ComputerArchitectureLab1
Project for the first Computer Architecture lab


Ερώτημα 1:

Τρέχοντας το script starter_se.py με τις παραμέτρους που δίνονται έχουμε:
 * Τύπος επεξεργαστή: Αρχιτεκτονική ARM, τύπος επεξεργαστή minor 1GHz με 1 πυρήνα
 * Μνήμη: DDR3 1600MHz 8x8 dual channel 2GB χωρίς ranks
 * Cache:
    - Level 1: 
        + Instruction Cache: 48kB 3-way associative
        + Data Cache: 32kB 2-way associative
    - TLB:
        1kB 8-way associative
    - Level 2 1MB 16-way associative

Μπορούμε να αλλάξουμε τη συχνότητα λειτουργίας του επεξεργαστή με τη παράμετρο --cpu-freq

Ερώτημα 2:
 * sim_seconds: πόσα δευτερόλεπτα έτρεξε η προσομοίωση (όχι σε πραγματικό χρόνο αλλά στο χρόνο όπως κυλάει στη προσομοίωση)
 * sim_insts: πόσες εντολές επεξεργαστή (ARM στη περίπτωση μας) προσομοιώθηκαν
 * host_inst_rate: ρυθμός προσομοίωσης εντολών ανά δευτερόλεπτο (σε πραγματικό χρόνο)
 
 
 Ερώτημα 3:
 
 Το CPI που φαίνεται αυτόματα στο αρχείο stats.txt είναι 6.991048. Εφαρμόζοντας την εξίσωση που μας δίνεται με sim_insts = 5027, system.cpu_cluster.cpus.dcache.overall_misses::total = 177, system.cpu_cluster.cpus.icache.overall_misses::total = 327 και system.cpu_cluster.l2.overall_accesses::total = 474 όμως το CPI είναι 6.316 093 097
 
 Ερώτημα 4:
 
 Στον gem5 τα in-order μοντέλα cpu είναι:
  * BaseSimpleCPU: βασικό μοντέλο cpu το οποίο δε χρησιμοποιείται από μόνο του, αλλά χρησιμοποιείται για να οριστούν άλλα μοντέλα cpu βάσει αυτού.
  * AtomicSimpleCPU: κληρονομεί χαρακτηριστικά από το BaseSimpleCPU και χρησιμοποιεί το Atomic μοντέλο πρόσβασης στη μνήμη, που είναι πολύ γρήγορο και δεν μοντελοποιεί συγκρούσεις για πόρους ή αναμονές σε ουρές.
  * TimingSimpleCPU: κληρονομεί επίσης χαρακτηριστικά από το BaseSimpleCPU και χρησιμοποιεί το Timing μοντέλο μνήμης, που είναι το πιο λεπτομερές που υποστηρίζει ο gem5. Μοντελοποιεί resource contentions και αναμονές σε ουρές για πρόσβαση στη μνήμη.
  * MinorCPU: CPU που χρησιμοποιεί pipeline σε 4 στάδια: fetch1, fetch2, decode και execute. Χρησιμοποιεί επίσης branch predictor.
  
α) Κάνουμε compile για ARM και τρέχουμε σαν Benchmark το πρόγραμμα test2.c στον gem5 με τα 2 μοντέλα CPU.
Το πρόγραμμα στον MinorCPU χρειάζεται στα 1024MHz 0.009399 δευτερόλεπτα για να τρέξει ενώ στον TimingSimpleCPU στα 1024MHz χρειάζεται 0.026339 δευτερόλεπτα, περίπου 2.8 φορές περισσότερο, πράγμα που εξηγείται από το γεγονός ότι η MinorCPU χρησιμοποιεί pipeline.

β) Τρέχοντας το πρόγραμμα για διάφορες συχνότητες επεξεργαστή έχουμε τα εξής αποτελέσματα (με πορτοκαλί απεικονίζεται ο TimingSimple και με μπλε ο MinorCPU:

![alt text](https://github.com/LeandrosTzotzis/ComputerArchitectureLab1/blob/main/freqAbs.png?raw=true)

Για να κάνουμε πιο χρήσιμες συγκρίσεις </br> κανονικοποιούμε τα αποτελέσματα διαιρώντας τα με το μεγαλύτερο χρόνο που χρειάστηκε (δηλαδή με τον χρόνο στα 64MHz):

![alt text](https://github.com/LeandrosTzotzis/ComputerArchitectureLab1/blob/main/relativeFreq.png?raw=true)

Παρατηρούμε πως για το πρόγραμμα που γράψαμε τουλάχιστον, οι σχετικοί χρόνοι στους 2 επεξεργαστές είναι πρακτικά ίδιοι, πράγμα που βέβαια ενδέχεται να έχει να κάνει με το πρόγραμμα που χρησιμοποιήσαμε.

Τρέχοντας το πρόγραμμα για διάφορες τεχνολογίες μνήμης έχουμε:
![alt text](https://github.com/LeandrosTzotzis/ComputerArchitectureLab1/blob/main/memoriesAbsMinor.png?raw=true)
![alt text](https://github.com/LeandrosTzotzis/ComputerArchitectureLab1/blob/main/memoriesAbsTiming.png?raw=true)

Για να συγκρίνουμε την ευαισθησία κανονικοποιούμε τα αποτελέσματα βάσει του μεγαλύτερου χρόνου που χρειάστηκε σε κάθε τύπο επεξεργαστή κανονικοποιούμε τα αποτελέσματα βάσει του μεγαλύτερου χρόνου που χρειάστηκε σε κάθε τύπο επεξεργαστή:

![alt text](https://github.com/LeandrosTzotzis/ComputerArchitectureLab1/blob/main/memRelativeTimes.png?raw=true)

Γίνεται ξεκάθαρο πως ο Minor επεξεργαστής είναι πιο ευαίσθητος στις αλλαγές της μνήμης. Αυτό συμβαίνει γιατί ο MinorCPU χρησιμοποιεί pipeline οπότε σε γενικές γραμμές εκτελεί εντολές πιο γρήγορα, πράγμα που σημαίνει πως η μνήμη λειτουργεί σαν bottleneck πιο συχνά. Δηλαδή στον ίδιο χρόνο που οι δύο επεξεργαστές περιμένουν δεδομένα από τη μνήμη ο MinorCPU θα έτρεχε πολλές παραπάνω εντολές.
