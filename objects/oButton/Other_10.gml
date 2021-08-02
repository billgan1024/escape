//adjust all draw properties so the logic isn't put in the draw event
//this is more efficient because draws run more than 240 times per second/use gpu power
//this also helps avoid batch breaks because no 
alphaScale = approach(alphaScale, alphaScaleTo, 0.08);
inStateTransitionAlpha = r >= oPersistent.tr1 && r <= oPersistent.tr2 && c >= oPersistent.tc1 
    && c <= oPersistent.tc2 ? oPersistent.sAlpha : 1;
flexScale = spr == undefined ? min(maxWidth/string_width(text), 1) : 1;

overallAlpha = oPersistent.alpha*alphaScale*inStateTransitionAlpha;
overallScale = scale*flexScale*customScale;