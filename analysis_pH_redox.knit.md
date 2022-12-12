
<!-- rnb-text-begin -->

---
title: "Infant fecal pH/redox analysis"
output: html_notebook
---

# Load libraries

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubGlicmFyeShnZ3NpZ25pZilcblxuYGBgIn0= -->

```r
library(ggsignif)

```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiV2FybmluZzogcGFja2FnZSDigJhnZ3NpZ25pZuKAmSB3YXMgYnVpbHQgdW5kZXIgUiB2ZXJzaW9uIDQuMi4yXG4ifQ== -->

```
Warning: package ‘ggsignif’ was built under R version 4.2.2
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


# Load and clean up data 

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBwSCBhbmQgcmVkb3ggd2l0aCBjbGluaWNhbCBkYXRhXG4jIyBTZWUgZGF0YS92YXJpYWJsZV9kZXNjcmlwdGlvbnNfZm9yX2ZlY2FsX3BIX2ZpbmFsLnhsc3ggZm9yIGV4cGxhbmF0aW9ucyBvZiB2YXJpYWJsZXNcbnBIX3JlZG94IDwtIHJlYWQuY3N2KFwiZGF0YS9mZWNhbF9wSF9maW5hbC5jc3ZcIilcblxuIyBTQ0ZBIGRhdGEgYnkgR0NcbiMjIElzb2J1dHlyYXRlLCBpc292YWxlcmF0ZSwgYW5kIHZhbGVyYXRlIHdlcmUgbm90IGRldGVjdGVkIGZvciBhbnkgc2FtcGxlc1xuIyMgVHdvIHNhbXBsZXMgaGF2ZSBiZWVuIG9taXR0ZWQgd2hlcmUgbm90aGluZyB3YXMgZGV0ZWN0ZWRcbiMjIEFsbCB2YWx1ZXMgaGF2ZSBiZWVuIG11bHRpcGxpZWQgYnkgMTAgKGRpbHV0aW9uIGZhY3RvcikgYW5kIGFyZSBpbiBtTVxuIyMgV2hlcmUgdmFsdWVzIHdlcmUgTkEvMCwgdGhleSBoYXZlIGJlZW4gcmVwbGFjZWQgd2l0aCBhIHBzZXVkb2NvdW50IGVxdWFsIHRvIHRoZSBsb3dlc3QgdmFsdWUgb2JzZXJ2ZWQgZm9yIHRoYXQgU0NGQVxuZ2MgPC0gcmVhZC5jc3YoXCJkYXRhL25pY3VfZ2NfY2xlYW5lZC5jc3ZcIilcblxuIyBDb21iaW5lXG5wSF9yZWRveCA8LSBwSF9yZWRveCAlPiVcbiAgbGVmdF9qb2luKGdjKSAlPiVcbiAgcmVsb2NhdGUoYWNldGF0ZTp0b3RhbCwgLmFmdGVyID0gcmVkb3gpXG5cblxuYGBgIn0= -->

```r
# pH and redox with clinical data
## See data/variable_descriptions_for_fecal_pH_final.xlsx for explanations of variables
pH_redox <- read.csv("data/fecal_pH_final.csv")

# SCFA data by GC
## Isobutyrate, isovalerate, and valerate were not detected for any samples
## Two samples have been omitted where nothing was detected
## All values have been multiplied by 10 (dilution factor) and are in mM
## Where values were NA/0, they have been replaced with a pseudocount equal to the lowest value observed for that SCFA
gc <- read.csv("data/nicu_gc_cleaned.csv")

# Combine
pH_redox <- pH_redox %>%
  left_join(gc) %>%
  relocate(acetate:total, .after = redox)

```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


## 16S

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->



<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


# pH and redox
## Analyze pH and redox in context of clinical data - birth stats

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBTdW1tYXJpemUgcEggYW5kIHJlZG94IHdpdGhpbiBpbmZhbnRzXG4jIyBOZWVkIHRvIGFjY291bnQgZm9yIE5BIHZhbHVlcyBpbiBzb21lIGNhc2VzXG5wSF9yZWRveF9zdW1tYXJ5IDwtIHBIX3JlZG94ICU+JVxuICBncm91cF9ieShTdWJqZWN0LCBCR0EsIGJ3LCBtYXRhYngpICU+JVxuICBzdW1tYXJpemUobWVhbl9wSCA9IG1lYW4ocEgsIG5hLnJtID0gVCksXG4gICAgICAgICAgICBzZV9wSCA9IHNkKHBILCBuYS5ybSA9IFQpL3NxcnQobGVuZ3RoKHdoaWNoKCFpcy5uYShwSCkpKSksXG4gICAgICAgICAgICBtZWFuX3JlZG94ID0gbWVhbihyZWRveCwgbmEucm0gPSBUKSxcbiAgICAgICAgICAgIHNlX3JlZG94ID0gc2QocmVkb3gsIG5hLnJtID0gVCkvc3FydChsZW5ndGgod2hpY2goIWlzLm5hKHJlZG94KSkpKSlcblxuIyBMaW5lYXIgbW9kZWxzIC0gcEhcbnBIX3JlZG94ICU+JVxuICBsbWVyKHBIIH4gbWF0YWJ4ICsgKDF8U3ViamVjdCksIGRhdGEgPSAuKSAlPiVcbiAgc3VtbWFyeSgpXG4jIEJHQSBwID0gMC4wMTZcbiMgYncgcCA9IDAuMDA0NlxuIyBtYXRhYnggcCA9IDAuNzZcblxuIyBFeGFtaW5lIGJpcnRoIHN0YXRzXG5wSF9CR0FfcGxvdCA8LSBnZ3Bsb3QocEhfcmVkb3gsIGFlcyh4ID0gQkdBLCB5ID0gcEgsIGNvbG9yID0gU3ViamVjdCkpICtcbiAgZ2VvbV9wb2ludCgpICtcbiAgZ2VvbV9lcnJvcmJhcihkYXRhID0gcEhfcmVkb3hfc3VtbWFyeSwgYWVzKHggPSBCR0EsIHltaW4gPSBtZWFuX3BILCB5bWF4ID0gbWVhbl9wSCwgY29sb3IgPSBTdWJqZWN0KSxcbiAgICAgICAgICAgICAgICB3aWR0aCA9IDAuNSwgaW5oZXJpdC5hZXMgPSBGKSArXG4gIGdlb21fZXJyb3JiYXIoZGF0YSA9IHBIX3JlZG94X3N1bW1hcnksIGFlcyh4ID0gQkdBLCB5bWluID0gbWVhbl9wSCAtIHNlX3BILFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgeW1heCA9IG1lYW5fcEggKyBzZV9wSCwgY29sb3IgPSBTdWJqZWN0KSxcbiAgICAgICAgICAgICAgICB3aWR0aCA9IDAuMjUsIGluaGVyaXQuYWVzID0gRikgK1xuICBsYWJzKHggPSBcIkJpcnRoIGdlc3RhdGlvbmFsIGFnZSAod2Vla3MpXCIsIHkgPSBcIkZlY2FsIHBIXCIsIGNvbG9yID0gXCJQYXJ0aWNpcGFudFwiKSArXG4gIGdlb21fdGV4dGJveChkYXRhID0gZGF0YS5mcmFtZSh4PTMzLCB5ID0gNywgbGFiZWwgPSBcIkxNTTxicj4qcCogPSAwLjAxNlwiKSxcbiAgICAgICAgICAgICAgIGFlcyh4LCB5LCBsYWJlbCA9IGxhYmVsKSwgaGFsaWduID0gMC41LCBmaWxsID0gTkEsIGJveC5jb2xvdXIgPSBOQSxcbiAgICAgICAgICAgICAgIGJveC5wYWRkaW5nID0gZ3JpZDo6dW5pdChyZXAoMCwgNCksIFwicHRcIiksIGluaGVyaXQuYWVzID0gRilcblxucEhfYndfcGxvdCA8LSBnZ3Bsb3QocEhfcmVkb3gsIGFlcyh4ID0gYncsIHkgPSBwSCwgY29sb3IgPSBTdWJqZWN0KSkgK1xuICBnZW9tX3BvaW50KCkgK1xuICBnZW9tX2Vycm9yYmFyKGRhdGEgPSBwSF9yZWRveF9zdW1tYXJ5LCBhZXMoeCA9IGJ3LCB5bWluID0gbWVhbl9wSCwgeW1heCA9IG1lYW5fcEgsIGNvbG9yID0gU3ViamVjdCksXG4gICAgICAgICAgICAgICAgd2lkdGggPSA0MCwgaW5oZXJpdC5hZXMgPSBGKSArXG4gIGdlb21fZXJyb3JiYXIoZGF0YSA9IHBIX3JlZG94X3N1bW1hcnksIGFlcyh4ID0gYncsIHltaW4gPSBtZWFuX3BIIC0gc2VfcEgsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB5bWF4ID0gbWVhbl9wSCArIHNlX3BILCBjb2xvciA9IFN1YmplY3QpLFxuICAgICAgICAgICAgICAgIHdpZHRoID0gMjAsIGluaGVyaXQuYWVzID0gRikgK1xuICBsYWJzKHggPSBcIkJpcnRoIHdlaWdodCAoZylcIiwgeSA9IFwiRmVjYWwgcEhcIiwgY29sb3IgPSBcIlBhcnRpY2lwYW50XCIpICtcbiAgZ2VvbV90ZXh0Ym94KGRhdGEgPSBkYXRhLmZyYW1lKHg9MTIyMCwgeSA9IDcsIGxhYmVsID0gXCJMTU08YnI+KnAqID0gMC4wMDQ2XCIpLFxuICAgICAgICAgICAgICAgYWVzKHgsIHksIGxhYmVsID0gbGFiZWwpLCBoYWxpZ24gPSAwLjUsIGZpbGwgPSBOQSwgYm94LmNvbG91ciA9IE5BLFxuICAgICAgICAgICAgICAgYm94LnBhZGRpbmcgPSBncmlkOjp1bml0KHJlcCgwLCA0KSwgXCJwdFwiKSwgaW5oZXJpdC5hZXMgPSBGKVxuXG5cbiMgTGluZWFyIG1vZGVscyAtIHJlZG94XG5wSF9yZWRveCAlPiVcbiAgbG1lcihyZWRveCB+IEJHQSArICgxfFN1YmplY3QpLCBkYXRhID0gLikgJT4lXG4gIHN1bW1hcnkoKVxuIyBCR0EgcCA9IDAuMDYwXG4jIGJ3IHAgPSAwLjE3XG4jIG1hdGFieCBwID0gMC44N1xuXG5yZWRveF9CR0FfcGxvdCA8LSBnZ3Bsb3QocEhfcmVkb3gsIGFlcyh4ID0gQkdBLCB5ID0gcmVkb3gsIGNvbG9yID0gU3ViamVjdCkpICtcbiAgZ2VvbV9wb2ludCgpICtcbiAgZ2VvbV9lcnJvcmJhcihkYXRhID0gcEhfcmVkb3hfc3VtbWFyeSwgYWVzKHggPSBCR0EsIHltaW4gPSBtZWFuX3JlZG94LFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgeW1heCA9IG1lYW5fcmVkb3gsIGNvbG9yID0gU3ViamVjdCksXG4gICAgICAgICAgICAgICAgd2lkdGggPSAwLjUsIGluaGVyaXQuYWVzID0gRikgK1xuICBnZW9tX2Vycm9yYmFyKGRhdGEgPSBwSF9yZWRveF9zdW1tYXJ5LCBhZXMoeCA9IEJHQSwgeW1pbiA9IG1lYW5fcmVkb3ggLSBzZV9yZWRveCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHltYXggPSBtZWFuX3JlZG94ICsgc2VfcmVkb3gsIGNvbG9yID0gU3ViamVjdCksXG4gICAgICAgICAgICAgICAgd2lkdGggPSAwLjI1LCBpbmhlcml0LmFlcyA9IEYpICtcbiAgbGFicyh4ID0gXCJCaXJ0aCBnZXN0YXRpb25hbCBhZ2UgKHdlZWtzKVwiLCB5ID0gXCJGZWNhbCByZWRveCBwb3RlbnRpYWwgKG1WKVwiLCBjb2xvciA9IFwiUGFydGljaXBhbnRcIikgK1xuICBnZW9tX3RleHRib3goZGF0YSA9IGRhdGEuZnJhbWUoeD0zMywgeSA9IC0yMDAsIGxhYmVsID0gXCJMTU08YnI+KnAqID0gMC4wNjBcIiksXG4gICAgICAgICAgICAgICBhZXMoeCwgeSwgbGFiZWwgPSBsYWJlbCksIGhhbGlnbiA9IDAuNSwgZmlsbCA9IE5BLCBib3guY29sb3VyID0gTkEsXG4gICAgICAgICAgICAgICBib3gucGFkZGluZyA9IGdyaWQ6OnVuaXQocmVwKDAsIDQpLCBcInB0XCIpLCBpbmhlcml0LmFlcyA9IEYpXG5cbnJlZG94X2J3X3Bsb3QgPC0gZ2dwbG90KHBIX3JlZG94LCBhZXMoeCA9IGJ3LCB5ID0gcmVkb3gsIGNvbG9yID0gU3ViamVjdCkpICtcbiAgZ2VvbV9wb2ludCgpICtcbiAgZ2VvbV9lcnJvcmJhcihkYXRhID0gcEhfcmVkb3hfc3VtbWFyeSwgYWVzKHggPSBidywgeW1pbiA9IG1lYW5fcmVkb3gsIHltYXggPSBtZWFuX3JlZG94LCBjb2xvciA9IFN1YmplY3QpLFxuICAgICAgICAgICAgICAgIHdpZHRoID0gNDAsIGluaGVyaXQuYWVzID0gRikgK1xuICBnZW9tX2Vycm9yYmFyKGRhdGEgPSBwSF9yZWRveF9zdW1tYXJ5LCBhZXMoeCA9IGJ3LCB5bWluID0gbWVhbl9yZWRveCAtIHNlX3JlZG94LFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgeW1heCA9IG1lYW5fcmVkb3ggKyBzZV9yZWRveCwgY29sb3IgPSBTdWJqZWN0KSxcbiAgICAgICAgICAgICAgICB3aWR0aCA9IDIwLCBpbmhlcml0LmFlcyA9IEYpICtcbiAgbGFicyh4ID0gXCJCaXJ0aCB3ZWlnaHQgKGcpXCIsIHkgPSBcIkZlY2FsIHJlZG94IHBvdGVudGlhbCAobVYpXCIsIGNvbG9yID0gXCJQYXJ0aWNpcGFudFwiKSArXG4gIGdlb21fdGV4dGJveChkYXRhID0gZGF0YS5mcmFtZSh4PTEyNTAsIHkgPSAtMzUwLCBsYWJlbCA9IFwiTE1NPGJyPipwKiA9IDAuMTdcIiksXG4gICAgICAgICAgICAgICBhZXMoeCwgeSwgbGFiZWwgPSBsYWJlbCksIGhhbGlnbiA9IDAuNSwgZmlsbCA9IE5BLCBib3guY29sb3VyID0gTkEsXG4gICAgICAgICAgICAgICBib3gucGFkZGluZyA9IGdyaWQ6OnVuaXQocmVwKDAsIDQpLCBcInB0XCIpLCBpbmhlcml0LmFlcyA9IEYpXG5cbiMgVGVzdCBCR0EtYncgY29ycmVsYXRpb25cbmNvci50ZXN0KHBIX3JlZG94X3N1bW1hcnkkQkdBLCBwSF9yZWRveF9zdW1tYXJ5JGJ3LCBtZXRob2QgPSBcInNwZWFybWFuXCIpXG4jIHAgPSAwLjAxMywgcmhvID0gMC43MVxuXG5CR0FfYndfcGxvdCA8LSBnZ3Bsb3QocEhfcmVkb3hfc3VtbWFyeSwgYWVzKHggPSBCR0EsIHkgPSBidywgY29sb3IgPSBTdWJqZWN0KSkgK1xuICBnZW9tX3BvaW50KCkgK1xuICBsYWJzKHggPSBcIkJpcnRoIGdlc3RhdGlvbmFsIGFnZSAod2Vla3MpXCIsIHkgPSBcIkJpcnRoIHdlaWdodCAoZylcIiwgY29sb3IgPSBcIlBhcnRpY2lwYW50XCIpICtcbiAgZ2VvbV90ZXh0Ym94KGRhdGEgPSBkYXRhLmZyYW1lKHg9MzIuNSwgeSA9IDkwMCwgbGFiZWwgPSBcIlNwZWFybWFuJ3MgJnJobzsgPSAwLjcxPGJyPipwKiA9IDAuMDEzXCIpLFxuICAgICAgICAgICAgICAgYWVzKHgsIHksIGxhYmVsID0gbGFiZWwpLCBoYWxpZ24gPSAwLjUsIGZpbGwgPSBOQSwgYm94LmNvbG91ciA9IE5BLFxuICAgICAgICAgICAgICAgYm94LnBhZGRpbmcgPSBncmlkOjp1bml0KHJlcCgwLCA0KSwgXCJwdFwiKSwgaW5oZXJpdC5hZXMgPSBGKVxuXG4jIHBIIGFuZCByZWRveCBwbG90XG5wSF9yZWRveCAlPiVcbiAgbG1lcihyZWRveCB+IHBIICsgKDF8U3ViamVjdCksIGRhdGEgPSAuKSAlPiVcbiAgc3VtbWFyeSgpXG4jIHAgPSAwLjEzXG5cbnBIX3JlZG94X3Bsb3QgPC0gZ2dwbG90KHBIX3JlZG94LCBhZXMoeCA9IHBILCB5ID0gcmVkb3gsIGNvbG9yID0gU3ViamVjdCkpICtcbiAgZ2VvbV9wb2ludCgpICtcbiAgbGFicyh4ID0gXCJGZWNhbCBwSFwiLCB5ID0gXCJGZWNhbCByZWRveCBwb3RlbnRpYWwgKG1WKVwiLCBjb2xvciA9IFwiUGFydGljaXBhbnRcIikgK1xuICBnZW9tX3RleHRib3goZGF0YSA9IGRhdGEuZnJhbWUoeD02LjYsIHkgPSAtNDAwLCBsYWJlbCA9IFwiTE1NPGJyPipwKiA9IDAuMTNcIiksXG4gICAgICAgICAgICAgICBhZXMoeCwgeSwgbGFiZWwgPSBsYWJlbCksIGhhbGlnbiA9IDAuNSwgZmlsbCA9IE5BLCBib3guY29sb3VyID0gTkEsXG4gICAgICAgICAgICAgICBib3gucGFkZGluZyA9IGdyaWQ6OnVuaXQocmVwKDAsIDQpLCBcInB0XCIpLCBpbmhlcml0LmFlcyA9IEYpXG5cbmBgYCJ9 -->

```r
# Summarize pH and redox within infants
## Need to account for NA values in some cases
pH_redox_summary <- pH_redox %>%
  group_by(Subject, BGA, bw, matabx) %>%
  summarize(mean_pH = mean(pH, na.rm = T),
            se_pH = sd(pH, na.rm = T)/sqrt(length(which(!is.na(pH)))),
            mean_redox = mean(redox, na.rm = T),
            se_redox = sd(redox, na.rm = T)/sqrt(length(which(!is.na(redox)))))

# Linear models - pH
pH_redox %>%
  lmer(pH ~ matabx + (1|Subject), data = .) %>%
  summary()
# BGA p = 0.016
# bw p = 0.0046
# matabx p = 0.76

# Examine birth stats
pH_BGA_plot <- ggplot(pH_redox, aes(x = BGA, y = pH, color = Subject)) +
  geom_point() +
  geom_errorbar(data = pH_redox_summary, aes(x = BGA, ymin = mean_pH, ymax = mean_pH, color = Subject),
                width = 0.5, inherit.aes = F) +
  geom_errorbar(data = pH_redox_summary, aes(x = BGA, ymin = mean_pH - se_pH,
                                             ymax = mean_pH + se_pH, color = Subject),
                width = 0.25, inherit.aes = F) +
  labs(x = "Birth gestational age (weeks)", y = "Fecal pH", color = "Participant") +
  geom_textbox(data = data.frame(x=33, y = 7, label = "LMM<br>*p* = 0.016"),
               aes(x, y, label = label), halign = 0.5, fill = NA, box.colour = NA,
               box.padding = grid::unit(rep(0, 4), "pt"), inherit.aes = F)

pH_bw_plot <- ggplot(pH_redox, aes(x = bw, y = pH, color = Subject)) +
  geom_point() +
  geom_errorbar(data = pH_redox_summary, aes(x = bw, ymin = mean_pH, ymax = mean_pH, color = Subject),
                width = 40, inherit.aes = F) +
  geom_errorbar(data = pH_redox_summary, aes(x = bw, ymin = mean_pH - se_pH,
                                             ymax = mean_pH + se_pH, color = Subject),
                width = 20, inherit.aes = F) +
  labs(x = "Birth weight (g)", y = "Fecal pH", color = "Participant") +
  geom_textbox(data = data.frame(x=1220, y = 7, label = "LMM<br>*p* = 0.0046"),
               aes(x, y, label = label), halign = 0.5, fill = NA, box.colour = NA,
               box.padding = grid::unit(rep(0, 4), "pt"), inherit.aes = F)


# Linear models - redox
pH_redox %>%
  lmer(redox ~ BGA + (1|Subject), data = .) %>%
  summary()
# BGA p = 0.060
# bw p = 0.17
# matabx p = 0.87

redox_BGA_plot <- ggplot(pH_redox, aes(x = BGA, y = redox, color = Subject)) +
  geom_point() +
  geom_errorbar(data = pH_redox_summary, aes(x = BGA, ymin = mean_redox,
                                             ymax = mean_redox, color = Subject),
                width = 0.5, inherit.aes = F) +
  geom_errorbar(data = pH_redox_summary, aes(x = BGA, ymin = mean_redox - se_redox,
                                             ymax = mean_redox + se_redox, color = Subject),
                width = 0.25, inherit.aes = F) +
  labs(x = "Birth gestational age (weeks)", y = "Fecal redox potential (mV)", color = "Participant") +
  geom_textbox(data = data.frame(x=33, y = -200, label = "LMM<br>*p* = 0.060"),
               aes(x, y, label = label), halign = 0.5, fill = NA, box.colour = NA,
               box.padding = grid::unit(rep(0, 4), "pt"), inherit.aes = F)

redox_bw_plot <- ggplot(pH_redox, aes(x = bw, y = redox, color = Subject)) +
  geom_point() +
  geom_errorbar(data = pH_redox_summary, aes(x = bw, ymin = mean_redox, ymax = mean_redox, color = Subject),
                width = 40, inherit.aes = F) +
  geom_errorbar(data = pH_redox_summary, aes(x = bw, ymin = mean_redox - se_redox,
                                             ymax = mean_redox + se_redox, color = Subject),
                width = 20, inherit.aes = F) +
  labs(x = "Birth weight (g)", y = "Fecal redox potential (mV)", color = "Participant") +
  geom_textbox(data = data.frame(x=1250, y = -350, label = "LMM<br>*p* = 0.17"),
               aes(x, y, label = label), halign = 0.5, fill = NA, box.colour = NA,
               box.padding = grid::unit(rep(0, 4), "pt"), inherit.aes = F)

# Test BGA-bw correlation
cor.test(pH_redox_summary$BGA, pH_redox_summary$bw, method = "spearman")
# p = 0.013, rho = 0.71

BGA_bw_plot <- ggplot(pH_redox_summary, aes(x = BGA, y = bw, color = Subject)) +
  geom_point() +
  labs(x = "Birth gestational age (weeks)", y = "Birth weight (g)", color = "Participant") +
  geom_textbox(data = data.frame(x=32.5, y = 900, label = "Spearman's &rho; = 0.71<br>*p* = 0.013"),
               aes(x, y, label = label), halign = 0.5, fill = NA, box.colour = NA,
               box.padding = grid::unit(rep(0, 4), "pt"), inherit.aes = F)

# pH and redox plot
pH_redox %>%
  lmer(redox ~ pH + (1|Subject), data = .) %>%
  summary()
# p = 0.13

pH_redox_plot <- ggplot(pH_redox, aes(x = pH, y = redox, color = Subject)) +
  geom_point() +
  labs(x = "Fecal pH", y = "Fecal redox potential (mV)", color = "Participant") +
  geom_textbox(data = data.frame(x=6.6, y = -400, label = "LMM<br>*p* = 0.13"),
               aes(x, y, label = label), halign = 0.5, fill = NA, box.colour = NA,
               box.padding = grid::unit(rep(0, 4), "pt"), inherit.aes = F)

```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


## Analyze pH and redox in context of clinical data longitudinally

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxucmVkb3hfRE9MX3Bsb3QgPC0gZ2dwbG90KHBIX3JlZG94LCBhZXMoeCA9IERPTCwgeSA9IHJlZG94LCBjb2xvciA9IFN1YmplY3QpKSArXG4gICNnZW9tX3BvbHlnb24oZGF0YSA9IGh1bGxfRE9MLCBhZXMoZmlsbCA9IFN1YmplY3QpLCBhbHBoYSA9IDAuMTgsIGxpbmV0eXBlID0gXCJibGFua1wiKSArXG4gIGdlb21fcG9pbnQoKSArXG4gIGdlb21fbGluZSgpICtcbiAgbGFicyh4ID0gXCJBZ2UgKGRheXMpXCIsIHkgPSBcIkZlY2FsIHJlZG94IHBvdGVudGlhbCAobVYpXCIsIGNvbG9yID0gXCJQYXJ0aWNpcGFudFwiKSArXG4gIGdlb21fdGV4dGJveChkYXRhID0gZGF0YS5mcmFtZSh4PTcwLCB5ID0gMTAwLCBsYWJlbCA9IFwiTE1NPGJyPipwKiA9IDAuMDA0NVwiKSxcbiAgICAgICAgICAgICAgIGFlcyh4LCB5LCBsYWJlbCA9IGxhYmVsKSwgaGFsaWduID0gMC41LCBmaWxsID0gTkEsIGJveC5jb2xvdXIgPSBOQSxcbiAgICAgICAgICAgICAgIGJveC5wYWRkaW5nID0gZ3JpZDo6dW5pdChyZXAoMCwgNCksIFwicHRcIiksIGluaGVyaXQuYWVzID0gRikgK1xuICBnZW9tX3BvbHlnb24oaHVsbCA9IFQpXG5cbmBgYCJ9 -->

```r
redox_DOL_plot <- ggplot(pH_redox, aes(x = DOL, y = redox, color = Subject)) +
  #geom_polygon(data = hull_DOL, aes(fill = Subject), alpha = 0.18, linetype = "blank") +
  geom_point() +
  geom_line() +
  labs(x = "Age (days)", y = "Fecal redox potential (mV)", color = "Participant") +
  geom_textbox(data = data.frame(x=70, y = 100, label = "LMM<br>*p* = 0.0045"),
               aes(x, y, label = label), halign = 0.5, fill = NA, box.colour = NA,
               box.padding = grid::unit(rep(0, 4), "pt"), inherit.aes = F) +
  geom_polygon(hull = T)

```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiV2FybmluZzogSWdub3JpbmcgdW5rbm93biBwYXJhbWV0ZXJzOiBodWxsXG4ifQ== -->

```
Warning: Ignoring unknown parameters: hull
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


# SCFA
## Analyze SCFA data in context of clinical data

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYWNlX3BIX3Bsb3QgPC0gZ2dwbG90KHBIX3JlZG94LCBhZXMoeCA9IHBILCB5ID0gYWNldGF0ZSwgY29sb3IgPSBTdWJqZWN0KSkgK1xuICBnZW9tX3BvaW50KCkgK1xuICBsYWJzKHggPSBcIkZlY2FsIHBIXCIsIHkgPSBcIkFjZXRhdGUgY29uY2VudHJhdGlvbiAobU0pXCIsIGNvbG9yID0gXCJQYXJ0aWNpcGFudFwiKSArXG4gIGdlb21fdGV4dGJveChkYXRhID0gZGF0YS5mcmFtZSh4PTYuOCwgeSA9IDE1MCwgbGFiZWwgPSBcIkxNTTxicj4qcCogPSAwLjAwMzBcIiksXG4gICAgICAgICAgICAgICBhZXMoeCwgeSwgbGFiZWwgPSBsYWJlbCksIGhhbGlnbiA9IDAuNSwgZmlsbCA9IE5BLCBib3guY29sb3VyID0gTkEsXG4gICAgICAgICAgICAgICBib3gucGFkZGluZyA9IGdyaWQ6OnVuaXQocmVwKDAsIDQpLCBcInB0XCIpLCBpbmhlcml0LmFlcyA9IEYpICtcbiAgXG4gIFxuXG5gYGBcblxuYGBgIn0= -->

```r
ace_pH_plot <- ggplot(pH_redox, aes(x = pH, y = acetate, color = Subject)) +
  geom_point() +
  labs(x = "Fecal pH", y = "Acetate concentration (mM)", color = "Participant") +
  geom_textbox(data = data.frame(x=6.8, y = 150, label = "LMM<br>*p* = 0.0030"),
               aes(x, y, label = label), halign = 0.5, fill = NA, box.colour = NA,
               box.padding = grid::unit(rep(0, 4), "pt"), inherit.aes = F) +
  
  

```

```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiRXJyb3I6IGF0dGVtcHQgdG8gdXNlIHplcm8tbGVuZ3RoIHZhcmlhYmxlIG5hbWVcbiJ9 -->

```
Error: attempt to use zero-length variable name
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


## Assess relationship between SCFA and pH/redox

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->



<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


# 16S
## Analyze 16S data in context of clinical data

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBEaXZlcnNpdHlcblxuIyBOTURTXG5cblxuYGBgIn0= -->

```r
# Diversity

# NMDS

```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


## Assess relationship between 16S and pH/redox

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->



<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


# Patch figures

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBGaWcuIDEgLSBiaXJ0aCBzdGF0cyBhbmQgcEgvcmVkb3hcbmZpZzEgPC0gcGxvdF9ncmlkKHBIX0JHQV9wbG90ICsgdGhlbWUobGVnZW5kLnBvc2l0aW9uID0gXCJub25lXCIpLFxuICAgICAgICAgICAgICAgICAgcEhfYndfcGxvdCArIHRoZW1lKGxlZ2VuZC5wb3NpdGlvbiA9IFwibm9uZVwiKSxcbiAgICAgICAgICAgICAgICAgIHJlZG94X0JHQV9wbG90ICsgdGhlbWUobGVnZW5kLnBvc2l0aW9uID0gXCJub25lXCIpLFxuICAgICAgICAgICAgICAgICAgcmVkb3hfYndfcGxvdCsgdGhlbWUobGVnZW5kLnBvc2l0aW9uID0gXCJub25lXCIpLFxuICAgICAgICAgICAgICAgICAgbmNvbCA9IDIsXG4gICAgICAgICAgICAgICAgICBsYWJlbHMgPSBjKFwiQVwiLCBcIkJcIiwgXCJDXCIsIFwiRFwiKSwgbGFiZWxfZm9udGZhY2UgPSBcInBsYWluXCIpICU+JVxuICBwbG90X2dyaWQoLiwgZ2V0X2xlZ2VuZChwSF9CR0FfcGxvdCksIHJlbF93aWR0aHMgPSBjKDgsMSkpXG5cbmBgYCJ9 -->

```r
# Fig. 1 - birth stats and pH/redox
fig1 <- plot_grid(pH_BGA_plot + theme(legend.position = "none"),
                  pH_bw_plot + theme(legend.position = "none"),
                  redox_BGA_plot + theme(legend.position = "none"),
                  redox_bw_plot+ theme(legend.position = "none"),
                  ncol = 2,
                  labels = c("A", "B", "C", "D"), label_fontface = "plain") %>%
  plot_grid(., get_legend(pH_BGA_plot), rel_widths = c(8,1))

```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiV2FybmluZzogUmVtb3ZlZCAxIHJvd3MgY29udGFpbmluZyBtaXNzaW5nIHZhbHVlcyAoZ2VvbV9wb2ludCkuV2FybmluZzogUmVtb3ZlZCAxIHJvd3MgY29udGFpbmluZyBtaXNzaW5nIHZhbHVlcyAoZ2VvbV9wb2ludCkuXG4ifQ== -->

```
Warning: Removed 1 rows containing missing values (geom_point).Warning: Removed 1 rows containing missing values (geom_point).
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



<!-- rnb-text-end -->

